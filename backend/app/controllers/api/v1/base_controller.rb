module Api
  module V1
    class BaseController < ActionController::API
      before_action :authenticate_request

      attr_reader :current_user

      private

      def authenticate_request
        header = request.headers["Authorization"]
        token = header.split(" ").last if header
        decoded = ::Identities::Services::TokenManager.decode(token)

        if decoded
          @current_user = ::Identities::User.find_by(id: decoded[:user_id])
        end

        render json: { error: "Unauthorized" }, status: :unauthorized unless @current_user
      end
    end
  end
end