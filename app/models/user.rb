class User < ApplicationRecord
  store :preferences, accessors: [:email_frequency], coder: JSON

  has_many :notifications, dependent: :destroy

  has_and_belongs_to_many :artists

  validates :name, :email, :provider, :uid, presence: true
  validates :email, uniqueness: true
  validates :uid, uniqueness: true

  devise :omniauthable, omniauth_providers: [:spotify]

  def follow_artist(artist)
    return if artists.include?(artist)
    artists << artist
  end

  def hash_metadata
    JSON.parse(metadata).with_indifferent_access
  end

  def first_name
    name.split(' ').first.titleize
  end
end
