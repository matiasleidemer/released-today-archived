module Factories
  class Artist
    def self.create(spotify_id)
      payload = RSpotify::Artist.find(spotify_id)

      ::Artist.find_or_create_by!(spotify_id: payload.id) do |artist|
        artist.name = payload.name
        artist.metadata = payload.to_json
      end
    end
  end
end
