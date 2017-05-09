require 'rails_helper'

RSpec.describe "Profile API", type: :request do
  let(:user) { FactoryGirl.create(:user) }
  let(:artist) { FactoryGirl.create(:artist) }
  let(:anoter_artist) { FactoryGirl.create(:artist, name: "Dummy", spotify_id: "1234") }

  describe "GET artists" do
    before { user.follow_artist(artist) }

    it_behaves_like "Profile API", :get, "/api/v1/me/artists"

    it "returns the user's followed artists" do
      get "/api/v1/me/artists", headers: { "X-Released-User-Token" => user.token }

      result = {
        artists: [
          {
            name: artist.name,
            spotify_id: artist.spotify_id,
            image_url: artist.image_url,
            metadata: artist.metadata
          }
        ]
      }

      expect(response.status).to eq(200)
      expect(response.body).to eq(result.to_json)
    end
  end

  describe "GET releases" do
    let!(:album) { FactoryGirl.create(:album, artist: artist) }

    before { user.follow_artist(artist) }

    it_behaves_like "Profile API", :get, "/api/v1/me/releases"

    it "returns the user's latest releases" do
      get "/api/v1/me/releases", headers: { "X-Released-User-Token" => user.token }

      result = {
        releases: [
          {
            id: album.id,
            name: album.name,
            released_at: album.released_at,
            spotify_id: album.spotify_id,
            image_url: album.image_url,
            number_of_tracks: album.number_of_tracks,
            artist: {
              id: album.artist.id,
              spotify_id: album.artist.spotify_id,
              name: album.artist.name
            }
          }
        ]
      }

      expect(response.status).to eq(200)
      expect(response.body).to eq(result.to_json)
    end
  end
end
