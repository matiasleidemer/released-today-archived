class FetchAndSendNewReleasesJob < ApplicationJob
  queue_as :default

  def perform
    FetchNewReleases.call
    SendNewReleases.call
  end
end
