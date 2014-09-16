module Organization
  class BankAccountsController < ApplicationController
    #authenticate

    before_action :load_organization
    before_action :authorize_organization_admin

    def new
      @bank_account = BankAccount.new
    end

    def create
      @bank_account = BankAccount.new(bank_account_params)
      @bank_account.ownable = @organization
      if @bank_account.save
        BankAccountVerificationWorker.perform_async(@bank_account.id)
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