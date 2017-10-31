class PreferencesController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def update
    current_user.update_attributes(permitted_params)
    redirect_to preferences_path, notice: 'Preferences updated successfully!'
  end

  private

  def permitted_params
    params.require(:user).permit(:name, :email_frequency)
  end
end
