class Artist < ApplicationRecord
  validates :name, :spotify_id, presence: true
end
