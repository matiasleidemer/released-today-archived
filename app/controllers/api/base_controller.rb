module Api
  class BaseController < ApplicationController
    skip_before_action :verify_authenticity_token

    def render_errors(resource)
      render json: resource, status: 422, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end
end
