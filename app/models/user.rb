class User < ApplicationRecord
  has_many :notifications, dependent: :destroy

  has_and_belongs_to_many :artists

  validates :name, :email, :provider, :uid, presence: true
  validates :email, uniqueness: true
  validates :uid, uniqueness: true

  devise :omniauthable, :omniauth_providers => [:spotify]

  def follow_artist(artist)
    return if artists.include?(artist)
    artists << artist
  end
end
