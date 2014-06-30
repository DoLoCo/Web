module Api
  module V1
    class OrganizationsController < Api::ApplicationController
      before_action :authenticate, only: [:mine, :create, :update, :destroy]

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
        organization = Organization.new(organization_params)
        organization.organization_admins.build(user: current_user)
        
        if organization.save
          OrganizationGeocodingWorker.perform_async(organization.id)
        end

        respond_with(organization)
      end

      def update #TODO create policy
        organization = Organization.find(params[:id])
        if organization.update(organization_params)
          OrganizationGeocodingWorker.perform_async(organization.id) if organization.address_changed?
        end
        respond_with(organization)
      end

      def destroy #TODO create policy
        
      end

    private

      def organization_params # TODO move to policy object
        params.require(:organization).permit(:name, :website, :phone_number, :description, :address_line1, :address_line2, :city, :state, :postal_code)
      end

    end
  end
end