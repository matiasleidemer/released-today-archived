class Album < ApplicationRecord
  belongs_to :artist

  has_many :notifications, dependent: :destroy

  validates :artist_id, :spotify_id, :name, :number_of_tracks, presence: true

  def self.create_from_spotify(payload, artist:)
    new(spotify_id: payload[:spotify_id]).tap do |album|
      album.name = payload[:name]
      album.image_url = payload[:image_url]
      album.number_of_tracks = payload[:number_of_tracks]
      album.released_at = payload[:released_at]
      album.metadata = payload[:metadata]
      album.artist = artist
      album.save
    end
  end

  def followers
    artist.users
  end

  def released_today?
    (Time.zone.yesterday..Time.zone.today).cover?(released_at)
  end
end
