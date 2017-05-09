class Artist < ApplicationRecord
  has_many :albums, dependent: :destroy
  has_and_belongs_to_many :users

  validates :name, :spotify_id, presence: true

  def image_url
    images = metadata.fetch("images", [])
    return if images.empty?

    images.first.fetch("url", "")
  end
end
