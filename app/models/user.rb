class User < ApplicationRecord
  has_and_belongs_to_many :artists

  validates :name, :email, :provider, :uid, presence: true
  validates :email, uniqueness: true
  validates :uid, uniqueness: true

  devise :omniauthable, :omniauth_providers => [:spotify]
end
