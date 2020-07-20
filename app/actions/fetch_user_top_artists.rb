# frozen_string_literal: true

class FetchUserTopArtists
  class << self
    def call(user, limit: 50, user_client: RSpotify::User)
      artists_ids = user_client.new(user.hash_metadata).top_artists(limit: limit).map(&:id)
      FollowArtists.call(user: user, artists_ids: artists_ids)
    rescue StandardError => e
      Bugsnag.notify(e)
      raise e
    end
  end
end
