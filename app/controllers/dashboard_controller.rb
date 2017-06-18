class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @albums = Album.joins(artist: :users)
                   .where('artists_users.user_id = ?', current_user.id)
                   .order('released_at DESC NULLS LAST')
                   .includes(:artist)
                   .page(params[:page])
                   .per(12)
  end
end
