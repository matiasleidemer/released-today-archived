class Artist < ApplicationRecord
  has_many :albums

  validates :name, :spotify_id, presence: true
end
