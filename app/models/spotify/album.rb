module Spotify
  class Album
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def self.find(album_id, client = RSpotify::Album)
      payload = JSON.parse(client.find(album_id).to_json).with_indifferent_access
      new(payload)
    end

    def name
      data[:name]
    end

    def spotify_id
      data[:id]
    end

    def image_url
      return nil if data[:images].empty?
      data[:images].first[:url]
    end

    def number_of_tracks
      # Seems to be from the client and not the api
      data[:tracks_cache].size
    end

    def released_at
      date = data[:release_date]
      date << "-01-01" if data[:release_date_precision] == "year"

      Date.parse(date)
    end

    def attributes
      {
        name: name,
        spotify_id: spotify_id,
        image_url: image_url,
        number_of_tracks: number_of_tracks,
        released_at: released_at,
        metadata: data
      }
    end
  end
end
