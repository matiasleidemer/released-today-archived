# frozen_string_literal: true

class FetchAndSendNewReleasesJob < ApplicationJob
  queue_as :default

  def perform
    authenticate_spotify

    FetchNewReleases.call
    SendNewReleases.call(Notification.pending)
  end

  private

  def authenticate_spotify
    AuthenticateSpotify.call(
      client_id: Rails.application.secrets.spotify_client_id,
      client_secret: Rails.application.secrets.spotify_client_secret,
      env: Rails.env
    )
  end
end
