class SpotifyCallbacksController < Devise::OmniauthCallbacksController
  def spotify
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in @user
      redirect_to dashboard_url, notice: "Logged in successfully"
    else
      redirect_to root_url, flash: "Something went wrong"
    end
  end

  def failure
    redirect_to root_path
  end
end
