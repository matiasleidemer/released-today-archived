class SpotifyCallbacksController < Devise::OmniauthCallbacksController
  def spotify
    repository = Repositories::UserRepository.new
    user = repository.create_from_omniauth(request.env["omniauth.auth"])

    if user.persisted?
      FetchNewUserArtistsJob.perform_later(user) if user.artists.empty?
      sign_in user
      redirect_to dashboard_url, notice: "Logged in successfully"
    else
      redirect_to root_url, notice: "Something went wrong"
    end
  end

  def failure
    redirect_to root_path
  end
end
