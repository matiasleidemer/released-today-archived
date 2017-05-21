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
      artist_repository = Repositories::ArtistRepository.new

      Spotify::Artist.find_all(artists_ids).each do |artist|
        user.follow_artist(artist_repository.create_or_update(artist.attributes))
      end
    end
  end
end
