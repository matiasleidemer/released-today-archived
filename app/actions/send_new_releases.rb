class SendNewReleases
  class << self
    def call(pending_notifications)
      pending_notifications.group_by(&:user).each_pair do |user, notifications|
        next unless user.send_releases?

        releases = notifications.map(&:album)
        NotificationsMailer.new_releases(user, releases).deliver_later
        Notification.mark_as_sent(notifications)
      end
    rescue Exception => error
      Bugsnag.notify(error)
      raise error
    end
  end
end
