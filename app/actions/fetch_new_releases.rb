class FetchNewReleases
  class << self
    def call
      timeout = ENV["RETRY_TIMEOUT"].to_i

      Spotify::ReleasesSyncer.call
    rescue RestClient::TooManyRequests
      puts "RestClient::TooManyRequests raised, waiting #{timeout} seconds..."
      sleep(timeout)

      call
    rescue Exception => error
      Bugsnag.notify(error)
      raise error
    end
  end
end
