require 'rails_helper'

RSpec.describe "Profile API", type: :request do
  let(:user) { FactoryGirl.create(:user) }
  let(:artist) { FactoryGirl.create(:artist) }
  let(:anoter_artist) { FactoryGirl.create(:artist, name: "Dummy", spotify_id: "1234") }

  describe "GET artists" do
    before { user.follow_artist(artist) }

    it "returns the user's followed artists" do
      get "/api/v1/me/artists", headers: { "X-Released-User-Token" => user.token }

      # TODO
      # I'm still not sure if I like this or not
      # If we rely on the serializer, maybe we should test it instead of a full
      # json response?
      result = {
        artists: [
          {
            name: "Dinosaur Jr.",
            spotify_id: "267VY6GX5LyU5c9M85ECZQ",
            image_url: "https://i.scdn.co/image/7c9a23b053f6f0862d860179b64a24e1b27dd6b3",
            metadata: {
              images: [
                {
                  height: 1000,
                  url: "https://i.scdn.co/image/7c9a23b053f6f0862d860179b64a24e1b27dd6b3",
                  width: 1000
                }
              ]
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
