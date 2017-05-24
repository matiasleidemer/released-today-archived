module Spotify
  class ReleasesSyncer
    class << self
      def call
        artist_repository = Repositories::ArtistRepository.new
        album_repository = Repositories::AlbumRepository.new
        notification_repository = Repositories::NotificationRepository.new

        artist_repository.stale.find_each do |artist|
          spotify_artist = Spotify::Artist.new(artist.metadata)

          spotify_artist.latest_releases.each do |release|
            next if album_repository.exists?(spotify_id: release.spotify_id)

            attributes = release.attributes.merge(artist_id: artist.id)
            album = album_repository.create(attributes)

            album.followers.each do |follower|
              notification_repository.create(album: album, user: follower)
            end
          end

          artist.touch
        end
      end
    end
  end
end
