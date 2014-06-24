module Api
  module V1
    class SessionsController < Api::ApplicationController
      before_action :authenticate, only: [:test]

      def create
        user = User.find_by(email: params[:email].downcase) if !params[:email].blank?
        if user && !params[:password].blank? && user.authenticate(params[:password])
          token = AuthToken.issue_token({ user_id: user.id })
          render json: { 
            user: UserSerializer.new(user).to_json,
            token: token 
          }
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