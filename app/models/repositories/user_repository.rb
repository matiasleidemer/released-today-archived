module Repositories
  class UserRepository
    attr_reader :model

    def initialize(model = User)
      @model = model
    end

    def find(id)
      model.find(id)
    end

    def find_by(params)
      model.find_by(params)
    end

    def find_or_create_from_omniauth(auth)
      model.where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.uid = auth.uid
        user.provider = auth.provider
        user.name = auth.info.name
        user.email = auth.info.email
        user.metadata = auth.to_json
        user.token ||= generate_token
      end
    end

    def create_from_api(data)
      record = model.new
      record.provider = data[:provider]
      record.uid = data[:uid]
      record.name = data[:name]
      record.email = data[:email]
      record.metadata = data[:metadata] && data[:metadata].to_json
      record.token = generate_token

      record.save

      record
    end

    private

    def generate_token
      token = SecureRandom.hex(20)

      while model.where(token: token).count > 0
        token = SecureRandom.hex(20)
      end

      token
    end
  end
end
