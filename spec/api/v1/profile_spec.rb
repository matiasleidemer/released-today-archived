require 'rails_helper'

RSpec.describe "Profile API", type: :request do
  let(:user) { FactoryGirl.create(:user) }
  let(:artist) { FactoryGirl.create(:artist) }
  let(:anoter_artist) { FactoryGirl.create(:artist, name: "Dummy", spotify_id: "1234") }

  before { user.follow_artist(artist) }

  describe "GET artists" do
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

    # TODO: turn this into a shared example?
    it "returns unauthorized if user token is invalid" do
      get "/api/v1/me/artists", headers: { "X-Released-User-Token" => "nope" }

      expect(response.status).to eq(401)
      expect(response.body).to eq("Bad credentials")
    end
  end

  describe "GET releases" do
    let!(:album) { FactoryGirl.create(:album, artist: artist) }

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

    # TODO: turn this into a shared example?
    it "returns unauthorized if user token is invalid" do
      get "/api/v1/me/artists", headers: { "X-Released-User-Token" => "nope" }

      expect(response.status).to eq(401)
      expect(response.body).to eq("Bad credentials")
    end
  end
end
