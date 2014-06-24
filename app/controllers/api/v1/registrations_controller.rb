module Api
  module V1
    class RegistrationsController < Api::ApplicationController

      def create
        user = User.new(registration_params)
        if user.save
          token = AuthToken.issue_token({ user_id: user.id })
          render json: { 
            user: UserSerializer.new(user).to_json,
            token: token 
          }
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

    private

      def registration_params
        params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
      end

    end
  end
end