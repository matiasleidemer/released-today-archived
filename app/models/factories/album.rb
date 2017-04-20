module Factories
  class Album
    def self.create_latest_from_artist(artist)
      payload = RSpotify::Artist.find(artist.spotify_id).albums.sort_by(&:release_date).last

      ::Album.find_or_create_by(spotify_id: payload.id) do |album|
        album.artist = artist
        album.spotify_id = payload.id
        album.name = payload.name
        album.image_url = payload.images.first["url"]
        album.number_of_tracks = payload.tracks.size
        album.released_at = payload.release_date
      end
    end
  end
end
