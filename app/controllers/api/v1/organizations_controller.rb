module Api
  module V1
    class OrganizationsController < Api::ApplicationController
      before_action :authenticate, only: [:mine, :create, :update, :destroy]

      after_action :verify_authorized, only: [:update, :destroy]

      set_pagination_headers :organizations, only: [:index, :mine]

      def index
        # TODO: filter based on search
        @organizations = Organization.paginate(page: params[:page], per_page: 10)
        respond_with(@organizations)
      end

      def mine
        @organizations = current_user.organizations.paginate(page: params[:page], per_page: 10)
        respond_with(@organizations)
      end

      def show
        respond_with(@organization = Organization.find(params[:id]))
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
        # TODO: not sure if the policy thing will work...
        params.require(:organization).permit(*policy(@organization || Organization).permitted_attributes)
      end

    end
  end
end