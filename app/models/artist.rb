class Artist < ApplicationRecord
  has_many :albums, dependent: :destroy

  validates :name, :spotify_id, presence: true
end
