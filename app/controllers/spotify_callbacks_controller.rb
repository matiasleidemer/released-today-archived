class SpotifyCallbacksController < Devise::OmniauthCallbacksController
  def spotify
    result = SignUpSpotifyUser.call(request.env['omniauth.auth'])

    if result.success?
      sign_in result.user
      redirect_to dashboard_url, notice: 'Logged in successfully'
    else
      redirect_to root_url, notice: 'Something went wrong'
    end
  end

  def failure
    redirect_to root_path
  end
end
