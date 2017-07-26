class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :album
  has_one :artist, through: :album

  validates :user_id, :album_id, presence: true
end
