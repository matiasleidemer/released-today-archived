# frozen_string_literal: true

class AuthenticateSpotify
  TEST = 'test'

  class << self
    attr_writer :authenticator

    def call(client_id: Rails.application.secrets.spotify_client_id,
             client_secret: Rails.application.secrets.spotify_client_secret,
             env: Rails.env)
      return if env == TEST

      authenticator.authenticate(client_id, client_secret)
    end

    def authenticator
      @authenticator || RSpotify
    end
  end
end
