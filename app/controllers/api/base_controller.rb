module Api
  class BaseController < ApplicationController
    skip_before_action :verify_authenticity_token

    def render_errors(resource)
      render json: resource, status: 422, serializer: ActiveModel::Serializer::ErrorSerializer
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
  end
end
