class Artist < ApplicationRecord
  has_many :albums, dependent: :destroy
  has_and_belongs_to_many :users

  validates :name, :spotify_id, presence: true
end
