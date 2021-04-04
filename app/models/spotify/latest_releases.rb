# frozen_string_literal: true

module Spotify
  class LatestReleases
    def initialize(artist, market: 'US', client: nil)
      @artist = artist
      @market = market
      @client = client || RSpotify::Artist.new(@artist.metadata)
    end

    def all
      Spotify::Album.find_collection(
        [fetch(:album), fetch(:single)].map(&:id)
      )
    end

    private

    def fetch(album_type)
      @client.albums(market: @market, album_type: album_type).first
    end
  end
end
