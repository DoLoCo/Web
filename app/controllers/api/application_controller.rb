module Api
  class ApplicationController < ActionController::Base
    include Pundit

    rescue_from Pundit::NotAuthorizedError, with: :render_user_not_authorized
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found

    protect_from_forgery with: :null_session

    respond_to :json

  protected

    def self.set_pagination_headers(name, options={})
      after_filter(options) do |controller|
        results = instance_variable_get("@#{name}")
        headers["X-Pagination"] = {
          total: results.total_entries,
          total_pages: results.total_pages,
          offset: results.offset
        }.to_json
      end
    end


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
end