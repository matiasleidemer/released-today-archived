# frozen_string_literal: true

class FetchNewReleases
  class << self
    def call(**options)
      timeout = ENV['RETRY_TIMEOUT'].to_i

      Spotify::ReleasesSyncer.call(**options)
    rescue RestClient::TooManyRequests
      Rails.logger.info "RestClient::TooManyRequests raised, waiting #{timeout} seconds..."
      sleep(timeout)

      call(**options)
    rescue StandardError => e
      Bugsnag.notify(e)
      raise e
    end
  end
end
