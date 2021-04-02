# frozen_string_literal: true

module Spotify
  class UserTopArtists
    TIME_RANGES = %i[short_term medium_term long_term].freeze

    def initialize(user)
      @user = user
    end

    def all_time_ranges(client: spotify_client)
      Set.new.tap do |artists|
        TIME_RANGES.each do |time_range|
          artists.merge(fetch(client: client, time_range: time_range))
        end
      end
    end

    def fetch(limit: 50, time_range: :short_term, client: spotify_client)
      Artist.build_from_collection(
        client.top_artists(limit: limit, time_range: time_range)
      )
    end

    private

    def spotify_client
      @spotify_client ||= RSpotify::User.new(@user.hash_metadata)
    end
  end
end
