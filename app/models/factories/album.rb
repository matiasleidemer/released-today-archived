module Factories
  class Album
    def self.create_latest_from_artist(artist)
      latest_album = RSpotify::Artist.find(artist.spotify_id).albums(album_type: 'album').sort_by(&:release_date).last
      latest_single = RSpotify::Artist.find(artist.spotify_id).albums(album_type: 'single').sort_by(&:release_date).last

      [latest_album, latest_single].each do |payload|
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
