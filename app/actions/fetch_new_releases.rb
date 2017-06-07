class FetchNewReleases
  class << self
    def call(**options)
      timeout = ENV["RETRY_TIMEOUT"].to_i

      Spotify::ReleasesSyncer.call(**options)
    rescue RestClient::TooManyRequests
      puts "RestClient::TooManyRequests raised, waiting #{timeout} seconds..."
      sleep(timeout)

      call(**options)
    rescue Exception => error
      Bugsnag.notify(error)
      raise error
    end
  end
end
