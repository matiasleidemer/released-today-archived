# frozen_string_literal: true

class Artist < ApplicationRecord
  has_many :albums, dependent: :destroy
  has_and_belongs_to_many :users

  validates :name, :spotify_id, presence: true

  scope :stale, lambda {
    where('updated_at < ?', 22.hours.ago).where('disabled_at is null')
  }

  def self.create_or_update_from_spotify(data)
    find_or_initialize_by(spotify_id: data[:spotify_id]).tap do |artist|
      artist.name = data[:name]
      artist.metadata = data[:metadata]
      artist.save
    end
  end

  def image_url
    images = metadata.fetch('images', [])
    return if images.empty?

    images.first.fetch('url', '')
  end
end
