# frozen_string_literal: true

class FetchUserTopArtists
  TIME_RANGES = %i[short_term medium_term long_term].freeze

  class << self
    def call(limit: 50, client:)
      Set.new.tap do |artists|
        TIME_RANGES.each do |time_range|
          top_artists = client.top_artists(limit: limit, time_range: time_range)
          artists.merge(Spotify::Artist.build_from_collection(top_artists))
        end
      end
    rescue StandardError => e
      Bugsnag.notify(e)
      raise e
    end
  end
end
