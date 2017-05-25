module Repositories
  class NotificationRepository
    attr_reader :model

    delegate_missing_to :@model

    def initialize(model = Notification)
      @model = model
    end

    def pending
      where(sent_at: nil).includes(album: :artist)
    end

    def mark_as_sent(notifications)
      notifications.each do |notification|
        notification.update_attribute(:sent_at, Time.zone.now)
      end
    end
  end
end
