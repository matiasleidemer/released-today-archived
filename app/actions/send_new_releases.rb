# frozen_string_literal: true

class SendNewReleases
  class << self
    def call(pending_notifications)
      pending_notifications.group_by(&:user).each_pair do |user, notifications|
        next unless user.send_releases?

        releases = notifications.map(&:album)
        NotificationsMailer.new_releases(user, releases).deliver_later
        Notification.mark_as_sent(notifications)
      end
    rescue StandardError => e
      Bugsnag.notify(e)
      raise e
    end
  end
end
