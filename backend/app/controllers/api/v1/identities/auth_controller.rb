module Api
  module V1
    module Identities
      class AuthController < BaseController
        skip_before_action :authenticate_request, only: [:login]

        def login
          # Use ::Identities::User to ensure we look up the model in the top-level namespace
          user = ::Identities::User.find_by(email: params[:email])

          if user&.authenticate(params[:password])
            token = ::Identities::Users::TokenManager.encode(user_id: user.id)
            render json: {
              token: token,
              user: {
                id: user.id,
                first_name: user.first_name,
                last_name: user.last_name,
                email: user.email
                }
              }
          else
            render json: { error: "Invalid email or password" }, status: :unauthorized
          end
        end
      end
    end
  end
end
