require 'rails_helper'
require 'released/jwt'

RSpec.describe "Profile API", type: :request do
  let(:user) { FactoryGirl.create(:user) }
  let(:jwt_token) { Released::Jwt.encode({ claims: { email: user.email } }) }
  let(:headers) { { "Authorization" => "Bearer #{jwt_token}" } }

  describe "GET artists" do
    let(:artist) { FactoryGirl.create(:artist) }

    before { user.follow_artist(artist) }

    it_behaves_like "Profile API", :get, "/api/v1/me/artists"

    it "returns the user's followed artists" do
      get "/api/v1/me/artists", headers: headers

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
    let(:artist) { FactoryGirl.create(:artist) }
    let!(:album) { FactoryGirl.create(:album, artist: artist) }

    before { user.follow_artist(artist) }

    it_behaves_like "Profile API", :get, "/api/v1/me/releases"

    it "returns the user's latest releases" do
      get "/api/v1/me/releases", headers: headers

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

  describe "POST add_artists" do
    it_behaves_like "Profile API", :post, "/api/v1/me/add_artists"

    it "creates new artists with the provided artists_ids parameter" do
      VCR.use_cassette "profile_add_artists" do
        expect(user.artists.count).to eq(0)
        expect(Artist.count).to eq(0)

        post "/api/v1/me/add_artists", params: { artists_ids: "4bcaz6nXnH8LTRiXALe8XV, 03xcT10aipgYbYqusG7GWY" }, headers: headers

        expect(Artist.count).to eq(2)
        expect(user.artists.count).to eq(2)
        expect(response.status).to eq(201)
        expect(response.body).to eq("")
      end
    end
  end
end
