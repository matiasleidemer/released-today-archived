class FetchNewReleasesJob < ApplicationJob
  queue_as :default

  def perform
    timeout = ENV["RETRY_TIMEOUT"].to_i

    Spotify::ReleasesSyncer.call
  rescue RestClient::TooManyRequests
    puts "RestClient::TooManyRequests raised, waiting #{timeout} seconds..."
    sleep(timeout)

    Spotify::ReleasesSyncer.call
  rescue Exception => error
    Bugsnag.notify(error)
    raise error
  end
end
