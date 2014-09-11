module Api
  module V1
    class DonationsController < Api::ApplicationController
      before_action :load_campaign

      set_pagination_headers :donations, only: [:index]

      def index
        @donations = @campaign.donations.ordered.paginate(page: params[:page], per_page: 50)
        respond_with(@donations)
      end

      def create
        @donation = @campaign.donations.build(donation_params)
        @donation.user = current_user

        authorize(@donation, :create?)

        if @donation.save
          InitiateDonationProcessWorker.perform_async(@donation.id)
        end
        
        respond_with(@donation, location: api_v1_organizations_url)
      end

    private

      def load_campaign
        @campaign ||= Campaign.find(params[:campaign_id])
      end

      def donation_params
        params.require(:donation).permit(*policy(@donation || Donation).permitted_attributes)
      end

    end
  end
end
