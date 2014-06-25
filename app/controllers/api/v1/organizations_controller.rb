module Api
  module V1
    class OrganizationsController < Api::ApplicationController
      before_action :authenticate, only: [:mine, :create, :update, :destroy]

      def index
        respond_with(Organization.all) # TODO: need to filter this
      end

      def mine
        respond_with(current_user.organizations)
      end

      def show
        respond_with(Organization.find(params[:id]))
      end

      def create
        # TODO:
        # validate and create organization
        # assign current_user to be one of the admins
        # push job to geocode the oranization's address
      end

      def update #TODO create policy
        # TODO:
        # validate and update organization
        # push job to geocode the organization's address if any part of the address has changed
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