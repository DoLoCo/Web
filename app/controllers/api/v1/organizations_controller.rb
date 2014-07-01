module Api
  module V1
    class OrganizationsController < Api::ApplicationController
      before_action :authenticate, only: [:mine, :create, :update, :destroy]

      after_action :verify_authorized, only: [:update, :destroy]

      def index
        respond_with(Organization.all) # TODO: need to filter this by location
      end

      def mine
        respond_with(current_user.organizations)
      end

      def show
        respond_with(Organization.find(params[:id]))
      end

      def create
        @organization = Organization.new(organization_params)
        @organization.organization_admins.build(user: current_user)
        
        if @organization.save
          OrganizationGeocodingWorker.perform_async(@organization.id)
        end

        respond_with(@organization)
      end

      def update
        @organization = Organization.find(params[:id])
        authorize(@organization, :update?)
        if @organization.update(organization_params)
          OrganizationGeocodingWorker.perform_async(@organization.id) if @organization.address_changed?
        end
        respond_with(@organization)
      end

      def destroy
        @organization = Organization.find(params[:id])
        authorize(@organization, :destroy?)
        @organization.destroy
        respond_with(@organization)
      end

    private

      def organization_params
        params.require(:organization).permit(*policy(@organization || Organization).permitted_attributes)
      end

    end
  end
end