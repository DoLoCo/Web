module Api
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session

    respond_to :json

  private

    def authenticate
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      authenticate_with_http_token do |token, options|
        @token = AuthToken.valid?(token)
      end
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="Application"'
      render json: { error: 'Authorization header not valid' }, status: :unauthorized
    end

    def current_user
      @current_user ||= User.find(@token.first['user_id']) if @token
    end
    
  end
end