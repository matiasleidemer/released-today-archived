class FetchNewUserArtistsJob < ApplicationJob
  queue_as :default

  def perform(user)
    FetchUserTopArtists.call(user)
    user.reload
    FetchNewReleases.call(artists: user.artists, send_notification: false)
  end
end
