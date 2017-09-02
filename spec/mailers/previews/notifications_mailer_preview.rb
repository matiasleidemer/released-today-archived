class NotificationsMailerPreview < ActionMailer::Preview
  def new_releases
    NotificationsMailer.new_releases(User.first, Album.all.limit(3))
  end
end
