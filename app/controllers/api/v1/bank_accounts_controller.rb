module Api
  module V1
    class BankAccountsController < Api::ApplicationController
      before_action :authenticate
      before_action :load_organization
      before_action :authorize_organization_admin

      set_pagination_headers :bank_accounts, only: [:index]

      def index
        @bank_accounts = @organization.bank_accounts.paginate(page: params[:page], per_page: 10)
        respond_with(@bank_accounts)
      end

      def show
        respond_with(@organization.bank_accounts.find(params[:id]))
      end

      def create # TODO: remove duplication between user/org bank account creation (move to service object)
        @bank_account = @organization.bank_accounts.build(bank_account_params)
          
        # TODO:
        # store last four account_number (do in before_save?)
        # create balancepayment bank_account
        # store gateway_reference_id from balancedpayment response
        if @bank_account.save
          # push job for bank account verification
        end

        respond_with(@bank_account)
      end

      def destroy # TODO: move logic into service object
        authorize(@bank_account, :destroy?)
        # remove from balancedpayments
        @bank_account.destroy # if the response came back successfully
        respond_with(@bank_account)
      end

    private

      def bank_account_params # Move into service object
        params.require(:bank_account).permit(*policy(@bank_account || BankAccount).permitted_attributes)
      end

      def load_organization
        @organization ||= Organization.find(params[:organization_id])
      end

      def authorize_organization_admin
        authorize(@organization, :show?)
      end

    end
  end
end