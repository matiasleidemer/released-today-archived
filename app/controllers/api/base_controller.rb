module Api
  class BaseController < ApplicationController
    skip_before_action :verify_authenticity_token

    def render_errors(resource)
      render json: resource, status: 422, serializer: ActiveModel::Serializer::ErrorSerializer
    end

    def render_unauthorized
      render json: 'Bad credentials', status: 401
    end

    private

    def schema
      params.require(:data).permit(:type, { attributes: attributes })
    end

    def resource_params
      schema[:attributes] || {}
    end

    def attributes
      raise "Implement me with an array of attributes"
    end

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
