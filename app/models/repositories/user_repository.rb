module Repositories
  class UserRepository
    attr_reader :model

    delegate_missing_to :@model

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
        user.email_frequency ||= 'daily'
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
      record.email_frequency = 'daily'
      record.token = generate_token

      record.save

      record
    end

    def find_from_authorization(payload = {})
      email = payload.dig('claims', 'email')
      model.find_by(email: email)
    end

    private

    def generate_token
      token = SecureRandom.hex(20)

      token = SecureRandom.hex(20) while model.where(token: token).count > 0

      token
    end
  end
end
