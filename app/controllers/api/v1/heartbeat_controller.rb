module Api
  module V1
    class HeartbeatController < Api::ApplicationController
      skip_before_action :authenticate

      def index
        render json: {}, status: :ok
      end

    end
  end
end