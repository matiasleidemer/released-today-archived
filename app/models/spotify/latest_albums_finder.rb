module Spotify
  # This is currently too tighted to RSpotify
  # For now we're gonna have to deal with it. For future implementations, however,
  # we need to find a way to decouple it. Maybe by introducing custom client?
  class LatestAlbumsFinder
    class << self
      def call(artist:, artist_client: RSpotify::Artist, album_client: RSpotify::Album)
        spotify_artist = artist_client.new(artist.metadata)

        album_client.find(albums_ids(spotify_artist)).map do |payload|
          album_data = JSON.parse(payload.to_json).with_indifferent_access
          Spotify::Album.new(album_data)
        end
      end

      private

      def albums_ids(artist)
        [latest_album(artist), latest_single(artist)].compact.map(&:id).uniq
      end

      def latest_album(artist)
        artist.albums(market: 'US', album_type: 'album').first
      end

      def latest_single(artist)
        artist.albums(market: 'US', album_type: 'single').first
      end
    end
  end
end
