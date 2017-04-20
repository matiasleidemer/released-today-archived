class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @albums = Album.order('released_at DESC').includes(:artist).limit(9)
  end
end
