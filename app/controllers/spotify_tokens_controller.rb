class SpotifyTokensController < ApplicationController
  # https://github.com/simontaen/SpotifyTokenSwap/
  
  require 'net/http'
  require 'net/https'
  require 'encrypted_strings'

  skip_before_action :verify_authenticity_token

  # This call takes a single POST parameter, "code", which
  # it combines with your client ID, secret and callback
  # URL to get an OAuth token from the Spotify Auth Service,
  # which it will pass back to the caller in a JSON payload.
  def swap
    auth_code = params[:code]

    http = Net::HTTP.new(spotify_accounts_endpoint.host, spotify_accounts_endpoint.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new("/api/token")
    request.add_field("Authorization", auth_header)
    request.form_data = {
      "grant_type" => "authorization_code",
      "redirect_uri" => Rails.application.secrets.client_callback_url,
      "code" => auth_code
    }

    response = http.request(request)

    # encrypt the refresh token before forwarding to the client
    if response.code.to_i == 200
      token_data = JSON.parse(response.body)
      refresh_token = token_data["refresh_token"]
      encrypted_token = refresh_token.encrypt(:symmetric, :password => encryption_secret)
      token_data["refresh_token"] = encrypted_token
      response.body = JSON.dump(token_data)
    end

    render json: response.body, status: response.code
  end

  # Request a new access token using the POST:ed refresh token
  def refresh
    http = Net::HTTP.new(spotify_accounts_endpoint.host, spotify_accounts_endpoint.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new("/api/token")
    request.add_field("Authorization", auth_header)

    encrypted_token = params[:refresh_token]
    refresh_token = encrypted_token.decrypt(:symmetric, :password => encryption_secret)

    request.form_data = {
      "grant_type" => "refresh_token",
      "refresh_token" => refresh_token
    }

    response = http.request(request)

    render json: response.body, status: response.code.to_i
  end

  private

  def encryption_secret
    Rails.application.secrets.spotify_token_swap_encryption_secret
  end

  def auth_header
    client_id = Rails.application.secrets.client_id
    client_secret = Rails.application.secrets.client_secret
    "Basic " + Base64.strict_encode64(client_id + ":" + client_secret)
  end

  def spotify_accounts_endpoint
    URI.parse("https://accounts.spotify.com")
  end
end
