module Api
  class BaseController < ApplicationController
    skip_before_action :verify_authenticity_token

    def render_errors(resource)
      render json: { errors: resource.errors }, status: 422
    end

    def render_unauthorized
      render json: 'Bad credentials', status: 401
    end

    private

    def authenticate_user
      authenticate_api_key || render_unauthorized
    end

    def authenticate_api_key
      token = request.headers['X-Released-User-Token']
      repository = Repositories::UserRepository.new

      @current_user = repository.find_by(token: token)
    end

    def current_user
      @current_user
    end
  end
end
