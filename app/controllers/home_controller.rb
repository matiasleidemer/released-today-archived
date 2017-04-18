class HomeController < ApplicationController
  def index
    redirect_to dashboard_url if current_user.present?
  end
end
