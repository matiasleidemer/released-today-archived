# frozen_string_literal: true

class FetchNewUserArtistsJob < ApplicationJob
  queue_as :default

  def perform(user)
    AuthenticateSpotify.call
    top_artists = Spotify::UserTopArtists.new(user).all_time_ranges
    FollowArtists.call(user: user, artists: top_artists)
    user.reload
    FetchNewReleases.call(artists: user.artists, send_notification: false)
  end
end
