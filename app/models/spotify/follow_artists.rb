module Spotify
  class FollowArtists
    attr_reader :user, :artists_ids

    def initialize(user:, artists_ids:)
      @user = user
      @artists_ids = artists_ids
    end

    def self.call(user:, artists_ids:)
      new(user: user, artists_ids: artists_ids).call
    end

    def call
      Spotify::Artist.find_all(artists_ids).each do |spotify_artist|
        user.follow_artist(
          ::Artist.create_or_update_from_spotify(spotify_artist.attributes)
        )
      end
    end
  end
end
