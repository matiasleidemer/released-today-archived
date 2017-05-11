class Album < ApplicationRecord
  belongs_to :artist

  validates :artist_id, :spotify_id, :name, :number_of_tracks,
            presence: true
end
