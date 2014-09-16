class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :render_user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index; end

protected

  def current_user
    @current_user ||= User.find(@token.first['user_id']) if @token
  end

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

  def render_user_not_authorized
    render json: { error: 'User not authorized to perform action' }, status: :unauthorized
  end

  def render_record_not_found
    render json: { error: 'Record not found' }, status: :not_found
  end
end
