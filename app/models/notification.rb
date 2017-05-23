class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :album

  validates :user_id, :album_id, presence: true
end
