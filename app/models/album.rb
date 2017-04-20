class Album < ApplicationRecord
  belongs_to :artist
  
  validates :artist_id, :spotify_id, :name, :image_url, :number_of_tracks,
            :released_at, presence: true
end
