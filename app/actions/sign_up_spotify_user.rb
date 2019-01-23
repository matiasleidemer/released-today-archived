class SignUpSpotifyUser
  attr_reader :auth

  Result = Struct.new(:success?, :user)

  def initialize(auth)
    @auth = auth
  end

  def self.call(auth)
    new(auth).call
  end

  def call
    user = User.find_or_create_from_omniauth(auth)
    return Result.new(false, user) unless user.persisted?

    FetchNewUserArtistsJob.perform_later(user) if user.artists.empty?

    Result.new(true, user)
  end
end
