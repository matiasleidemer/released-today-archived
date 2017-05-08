require 'rails_helper'

RSpec.describe "Users API", type: :request do
  let(:user) { User.create!(provider: 'spotify', uid: '123', name: 'Foo', email: 'foo@bar.com')}

  describe "GET show" do
    it "returns the user's data" do
      get "/api/v1/users/#{user.id}"

      result = {
        data: {
          id: user.id.to_s,
          type: 'users',
          attributes: {
            name: 'Foo',
            email: 'foo@bar.com',
            provider: 'spotify',
            uid: '123',
            metadata: nil
          }
        }
      }

      expect(response.status).to eq(200)
      expect(response.body).to eq(result.to_json)
    end
  end

  describe "POST create" do
    context "with valid parameters" do
      let(:params) do
        {
          data: {
            type: 'users',
            attributes: {
              name: 'John Snow',
              email: 'john@snow.com',
              provider: 'spotify',
              uid: '456',
            }
          }
        }
      end

      it "creates and returns a new user" do
        post "/api/v1/users", params: params

        result = {
          data: {
            id: User.last.id.to_s,
            type: 'users',
            attributes: {
              name: 'John Snow',
              email: 'john@snow.com',
              provider: 'spotify',
              uid: '456',
              metadata: nil
            }
          }
        }

        expect(response.status).to eql(200)
        expect(response.body).to eql(result.to_json)
      end
    end

    context "with invalid parameters" do
      let(:params) do
        {
          data: {
            type: 'users',
            attributes: {
              name: 'John Snow',
              email: '',
              provider: 'spotify',
              uid: '',
            }
          }
        }
      end

      it "returns the resource errors" do
        post "/api/v1/users", params: params

        result = {
          errors: [
            {
              source: { pointer: "/data/attributes/email" },
              detail: "can't be blank" },
            {
              source: { pointer: "/data/attributes/uid" },
              detail: "can't be blank"
            }
          ]}

        expect(response.status).to eql(422)
        expect(response.body).to eql(result.to_json)
      end
    end
  end
end
