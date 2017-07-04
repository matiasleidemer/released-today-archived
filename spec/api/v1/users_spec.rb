require 'rails_helper'

RSpec.describe "Users API", type: :request do
  let(:user) { FactoryGirl.create(:user) }

  describe "GET show" do
    it "returns the user's data" do
      get "/api/v1/users/#{user.id}"

      result = {
        user: {
          id: user.id,
          name: user.name,
          email: user.email,
          provider: user.provider,
          uid: user.uid,
          metadata: user.metadata,
          token: user.token
        }
      }

      expect(response.status).to eq(200)
      expect(response.body).to eq(result.to_json)
    end
  end

  describe "POST create" do
    context "with valid parameters" do
      let(:params) do
        FactoryGirl
          .build(:user_params)
          .merge(metadata: { foo: :bar })
      end

      it "creates and returns a new user" do
        post "/api/v1/users", params: params
        user = User.last

        result = {
          user: {
            id: user.id,
            name: user.name,
            email: user.email,
            provider: user.provider,
            uid: user.uid,
            metadata: { foo: :bar }.to_json,
            token: user.token
          }
        }

        expect(response.status).to eql(200)
        expect(response.body).to eql(result.to_json)
      end
    end

    context "with invalid parameters" do
      let(:params) do
        {
          name: 'John Snow',
          email: '',
          provider: 'spotify',
          uid: ''
        }
      end

      it "returns the resource errors" do
        post "/api/v1/users", params: params

        result = {
          errors: {
            email: ["can't be blank"],
            uid: ["can't be blank"]
          }
        }

        expect(response.status).to eql(422)
        expect(response.body).to eql(result.to_json)
      end
    end
  end
end
