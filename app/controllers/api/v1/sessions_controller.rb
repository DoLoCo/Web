module Api
  module V1
    class SessionsController < Api::ApplicationController
      before_action :authenticate, only: [:test]

      def create
        if params[:email] && params[:password]
          user = User.find_by(email: params[:email].downcase)
          if user && user.authenticate(params[:password])
            token = AuthToken.issue_token({ user_id: user.id })
            render json: { user: user, token: token }
          else
            render json: { error: "Invalid email/password combination" }, status: :unauthorized
          end
        else
          render json: { error: "Invalid email/password combination" }, status: :unauthorized
        end
      end

      def test
        render json: 'Works!', status: :ok
      end

    end
  end
end