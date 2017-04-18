class User < ApplicationRecord
  devise :omniauthable, :omniauth_providers => [:spotify]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.uid = auth.uid
      user.provider = auth.provider
      user.name = auth.info.name
      user.email = auth.info.email
      user.metadata = auth.to_json
    end
  end
end
