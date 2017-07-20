require 'released/jwt'

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

    def authorization
      token = request.headers['Authorization'].split(" ").last
      @authorization ||= Released::Jwt.decode(token).first
    rescue JWT::DecodeError
      {}
    end

    def authenticate_user
      repo = Repositories::UserRepository.new
      user = repo.find_from_authorization(authorization)
      render_unauthorized if user.nil?
      @current_user = user
    end

    def current_user
      @current_user
    end
  end
end
