module Api
  module V1
    module Personal
      class DonationsController < Api::ApplicationController

        set_pagination_headers :donations, only: [:index]

        def index
          @donations = current_user.donations.ordered.paginate(page: params[:page], per_page: 10)
          respond_with(@donations)
        end

      end
    end
  end
end