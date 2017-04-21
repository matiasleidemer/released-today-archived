module API
  class Base < Grape::API
    version 'v1', using: :path
    format :json
    prefix :api

    resource :users do
      desc 'Creates a new user with provided params'
      params do
        requires :uid, type: String, desc: "User's UID"
        requires :provider, type: String, desc: "User's OAuth provider"
        requires :name, type: String, desc: "User's name"
        requires :email, type: String, desc: "User's email"
        optional :metadata, type: String, desc: "User's metadata"
      end
      post do
        user = ::User.build_from_api(params)

        if user.valid?
          user.save!
        else
          error!({ errors: user.errors.messages }, 422)
        end
      end
    end
  end
end
