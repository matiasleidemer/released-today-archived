module Spotify
  class Album
    attr_reader :payload

    def initialize(payload)
      @payload = payload.with_indifferent_access
    end

    def self.find(album_id, client = RSpotify::Album)
      payload = JSON.parse(client.find(album_id).to_json).with_indifferent_access
      new(payload)
    end

    def name
      payload[:name]
    end

    def spotify_id
      payload[:id]
    end

    def image_url
      return nil if payload[:images].empty?
      payload[:images].first[:url]
    end

    def number_of_tracks
      # Seems to be from the client and not the api
      payload[:tracks_cache].size
    end

    def released_at
      date = payload[:release_date]
      date << case payload[:release_date_precision]
      when "year"
        "-01-01"
      when "month"
        "-01"
      else
        ""
      end

      Date.parse(date)
    end

    def attributes
      {
        name: name,
        spotify_id: spotify_id,
        image_url: image_url,
        number_of_tracks: number_of_tracks,
        released_at: released_at,
        metadata: payload
      }
    end
  end
end
