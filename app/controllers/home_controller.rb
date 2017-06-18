class HomeController < ApplicationController
  def index
    if current_user.present?
      redirect_to dashboard_url
    else
      render layout: 'landing_page'
    end
  end
end
