class HomeController < ApplicationController
  def index
    authenticate_spotify

    if current_user.present?
      redirect_to dashboard_url
    else
      render layout: 'landing_page'
    end
  end

  private

  def authenticate_spotify
    return if Rails.env == 'test'

    RSpotify.authenticate(
      Rails.application.secrets.client_id,
      Rails.application.secrets.client_secret
    )
  end
end
