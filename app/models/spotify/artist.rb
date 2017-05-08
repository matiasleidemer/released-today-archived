module Spotify
  class Artist
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def self.find(artist_id, client = RSpotify::Artist)
      payload = JSON.parse(client.find(artist_id).to_json).with_indifferent_access
      new(payload)
    end

    def self.find_all(artists_ids, client = RSpotify::Artist)
      artists = JSON.parse(client.find(artists_ids).to_json)
      artists.map { |payload| new(payload.with_indifferent_access) }
    end

    def latest_albums
      Spotify::LatestAlbumsFinder.call(artist: self)
    end

    def name
      data[:name]
    end

    def spotify_id
      data[:id]
    end

    def metadata
      data
    end

    def attributes
      {
        name: name,
        spotify_id: spotify_id,
        metadata: data
      }
    end
  end
end
