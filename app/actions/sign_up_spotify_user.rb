class SignUpSpotifyUser
  attr_reader :auth, :user_repository

  Result = Struct.new(:success?, :user)

  def initialize(auth, user_repository: Repositories::UserRepository.new)
    @auth = auth
    @user_repository = user_repository
  end

  def self.call(auth)
    new(auth).call
  end

  def call
    user = user_repository.find_or_create_from_omniauth(auth)
    return Result.new(false, user) unless user.persisted?

    FetchNewUserArtistsJob.perform_later(user) if user.artists.empty?

    Result.new(true, user)
  end
end
