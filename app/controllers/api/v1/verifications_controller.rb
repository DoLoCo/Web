module Api
  module V1
    class VerificationsController < Api::ApplicationController
      before_action :load_organization

      def create
        
      end

      private

      def load_organization
        @organization ||= Organization.find(params[:organization_id])
      end

    end
  end
end