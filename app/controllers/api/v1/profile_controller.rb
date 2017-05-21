module Api
  module V1
    class ProfileController < Api::BaseController
      before_action :authenticate_user

      def artists
        render json: current_user.artists
      end

      def releases
        repository = Repositories::AlbumRepository.new
        render json: repository.user_releases(current_user), root: "releases"
      end

      def add_artists
        Spotify::FollowArtists.call(user: current_user, artists_ids: artists_ids)

        head :created
      end

      private

      def resource_params
        params.permit(:artists_ids)
      end

      def artists_ids
        resource_params[:artists_ids].split(",").map(&:strip)
      end
    end
  end
end
