module Spotify
  class ReleasesSyncer
    class << self
      def call
        artist_repository = Repositories::ArtistRepository.new
        album_repository = Repositories::AlbumRepository.new

        artist_repository.stale.find_each do |artist|
          spotify_artist = Spotify::Artist.new(artist.metadata)

          spotify_artist.latest_releases.each do |album|
            attributes = album.attributes.merge(artist_id: artist.id)
            album_repository.create_or_update(attributes)
          end

          artist.touch
        end
      end
    end
  end
end
