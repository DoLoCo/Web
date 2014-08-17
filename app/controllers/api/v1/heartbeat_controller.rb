module Api
  module V1
    class HeartbeatController < Api::ApplicationController

      def index
        render json: {}, status: :ok
      end

    end
  end
end