module Api
  module V1
    class CampaignsController < Api::ApplicationController
      before_action :authenticate, only: [:create, :update, :destroy]

      before_action :load_organization, only: [:create, :update, :destroy]
      before_action :load_campaign, only: [:show, :update, :destroy]

      set_pagination_headers :campaigns, only: [:index]

      def index
        # TODO: filter based on search
        # TODO: optional by organization (if params[:organization_id] is present), for now omit
        @campaigns = Campaign.paginate(page: params[:page], per_page: 10)
        respond_with(@campaigns)
      end

      def show
        respond_with(@campaign)
      end

      def create
        # authorize create
        # build campaign from organization
        # save and respond with json
      end

      def update
        # authorize update on campaign/org
        # update campaign
        # respond with json
      end

      def destroy
        # authorize destroy on campaign/org
        # destroy
        # respond with json
      end

    private

      def load_organization
        @organization = Organization.find(params[:organization_id])
      end

      def load_campaign
        @campaign = Campaign.find(params[:id])
      end

    end
  end
end