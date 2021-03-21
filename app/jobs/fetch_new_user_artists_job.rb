# frozen_string_literal: true

class FetchNewUserArtistsJob < ApplicationJob
  queue_as :default

  def perform(user)
    AuthenticateSpotify.call
    top_artists = FetchUserTopArtists.call(client: RSpotify::User.new(user.hash_metadata))
    FollowArtists.call(user: user, artists: top_artists)
    user.reload
    FetchNewReleases.call(artists: user.artists, send_notification: false)
  end
end
