class User < ApplicationRecord
  validates :name, :email, :provider, :uid, presence: true
  validates :email, uniqueness: true
  validates :uid, uniqueness: true

  devise :omniauthable, :omniauth_providers => [:spotify]
end
