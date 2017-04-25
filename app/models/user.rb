class User < ApplicationRecord
  validates :name, :email, :provider, :uid, presence: true
  validates :email, uniqueness: true
  validates :uid, uniqueness: true

  devise :omniauthable, :omniauth_providers => [:spotify]

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
