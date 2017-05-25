class SendNewReleasesJob < ApplicationJob
  queue_as :default

  def perform
    repository = Repositories::NotificationRepository.new

    repository.pending.group_by(&:user).each_pair do |user, notifications|
      releases = notifications.map(&:album)
      NotificationsMailer.new_releases(user, releases).deliver_later
      repository.mark_as_sent(notifications)
    end
  rescue Exception => error
    Bugsnag.notify(error)
    raise error
  end
end
