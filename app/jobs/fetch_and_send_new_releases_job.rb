class FetchAndSendNewReleasesJob < ApplicationJob
  queue_as :default

  def perform
    FetchNewReleases.call
    SendNewReleases.call(Notification.pending)
  end
end
