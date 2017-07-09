module Api
  module V1
    class UsersController < Api::BaseController
      def show
        render json: repository.find(params[:id])
      end

      def find
        render json: repository.find_by_email(params[:email])
      end

      def create
        user = repository.create_from_api(resource_params)

        if user.errors.empty?
          render json: user
        else
          render_errors(user)
        end
      end

      private

      def repository
        @repository ||= Repositories::UserRepository.new
      end

      def resource_params
        params.permit(:name, :email, :provider, :uid, :metadata).tap do |whitelist|
          whitelist[:metadata] = params[:metadata]
        end
      end
    end
  end
end
