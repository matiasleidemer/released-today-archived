module Factories
  class Album
    def self.create_latest_from_artist(artist)
      spotify_artist = RSpotify::Artist.find(artist.spotify_id)

      latest_album  = spotify_artist.albums(limit: 1, market: 'US', album_type: 'album').first
      latest_single = spotify_artist.albums(limit: 1, market: 'US', album_type: 'single').first

      albums = RSpotify::Album.find([latest_album.id, latest_single.id])

      albums.each do |payload|
        ::Album.find_or_create_by(spotify_id: payload.id) do |album|
          album.artist_id = artist.id
          album.spotify_id = payload.id
          album.name = payload.name
          album.image_url = payload.images.first["url"]
          album.number_of_tracks = payload.tracks.size
          album.released_at = payload.release_date
        end
      end
    end
  end
end
