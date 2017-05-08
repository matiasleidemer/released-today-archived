module Api
  module V1
    class UsersController < Api::BaseController
      def show
        render json: repository.find(params[:id])
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

      def attributes
        [:name, :email, :provider, :uid, :metadata]
      end
    end
  end
end
