module Api
  module V1
    class BankAccountsController < Api::ApplicationController
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

      def create
        bank_account_service = BankAccountCreate.new(bank_account_params, @organization)
        @bank_account = bank_account_service.save!

        respond_with(@bank_account)
      end

      def destroy # TODO: move logic into service object
        authorize(@bank_account, :destroy?)
        
        begin
          gateway_bank_account = Balanced::BankAccount.fetch("/bank_accounts/#{@bank_account.gateway_reference_id}")
          gateway_bank_account.unstore
          @bank_account.destroy
        rescue Balanced::Error => e
          # TODO: log error and/or return the appropriate status code
        end
        
        respond_with(@bank_account)
      end

    private

      def bank_account_params
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