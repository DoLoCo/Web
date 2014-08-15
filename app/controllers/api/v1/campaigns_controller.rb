module Api
  module V1
    class CampaignsController < Api::ApplicationController
      before_action :authenticate, only: [:create, :update, :destroy]

      before_action :load_organization, only: [:create, :update, :destroy]
      before_action :load_campaign, only: [:show, :update, :destroy]

      set_pagination_headers :campaigns, only: [:index]

      def index
        @campaigns = Campaign.paginate(page: params[:page], per_page: 10)

        if !params[:latitude].blank? && !params[:longitude].blank?
          @campaigns = @campaigns.by_distance_from_coordinates(params[:latitude], params[:longitude])
        end

        if !params[:organization_id]
          @campaigns = @campaigns.by_organization_id(params[:organization_id])
        end

        respond_with(@campaigns)
      end

      def show
        respond_with(@campaign)
      end

      def create
        @campaign = @organization.campaigns.build(campaign_params)
        authorize(@campaign, :create?)
        @campaign.save
        respond_with(@campaign)
      end

      def update
        authorize(@campaign, :update?)
        @campaign.update(campaign_params)
        respond_with(@campaign)
      end

      def destroy
        authorize(@campaign, :destroy?)
        @campaign.destroy
        respond_with(@campaign)
      end

    private

      def load_organization
        @organization = Organization.find(params[:organization_id])
      end

      def load_campaign
        @campaign = Campaign.find(params[:id])
      end

      def campaign_params
        params.require(:campaign).permit(*policy(@campaign || Campaign).permitted_attributes)
      end

    end
  end
end