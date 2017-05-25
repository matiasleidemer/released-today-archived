class NotificationsMailer < ApplicationMailer
  def new_releases(user, releases)
    @user = user
    @releases = releases

    mail to: @user.email, subject: 'New releases for you!'
  end
end
