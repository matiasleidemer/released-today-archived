# frozen_string_literal: true

class FollowArtists
  def self.call(user:, artists:)
    artists.each do |artist|
      user.follow_artist(Artist.create_or_update_from_spotify(artist.attributes))
    end
  end
end
