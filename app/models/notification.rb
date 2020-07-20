# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :album
  has_one :artist, through: :album

  validates :user_id, :album_id, presence: true

  scope :pending, -> { where(sent_at: nil) }

  def self.mark_as_sent(notifications)
    notifications.each do |notification|
      notification.update_attribute(:sent_at, Time.zone.now)
    end
  end
end
