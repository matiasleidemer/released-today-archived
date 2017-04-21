class User < ApplicationRecord
  validates :name, :email, :provider, :uid, presence: true
  validates :email, uniqueness: true
  validates :uid, uniqueness: true

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

  def self.build_from_api(params)
    User.new.tap do |user|
      user.uid = params[:uid]
      user.provider = params[:provider]
      user.name = params[:name]
      user.email = params[:email]
      user.metadata = params[:metadata]
    end
  end
end
