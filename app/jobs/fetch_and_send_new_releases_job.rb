# frozen_string_literal: true

class FetchAndSendNewReleasesJob < ApplicationJob
  queue_as :default

  def perform
    AuthenticateSpotify.call
    FetchNewReleases.call
    SendNewReleases.call(Notification.pending)
  end
end
