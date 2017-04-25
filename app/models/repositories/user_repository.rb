module Repositories
  class UserRepository
    attr_reader :model

    def initialize(model = User)
      @model = model
    end

    def create_from_omniauth(auth)
      model.where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.uid = auth.uid
        user.provider = auth.provider
        user.name = auth.info.name
        user.email = auth.info.email
        user.metadata = auth.to_json
      end
    end
  end
end
