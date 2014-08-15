module Api
  module V1
    class VerificationsController < Api::ApplicationController
      before_action :load_organization
      before_action :load_bank_account

      def create
        authorize(@bank_account, :update?)
        
        verification = BankAccountVerification.new(@bank_account)
        if verification.valid?(verification_params)
          render status: :no_content
        else
          render json: { error: 'Invalid verification.' }, status: :unprocessable_entity
        end
      end

      private

      def load_organization
        @organization ||= Organization.find(params[:organization_id])
      end

      def load_bank_account
        @bank_account ||= @organization.bank_accounts.find(params[:bank_account_id])
      end

      def verification_params
        params.permit(:amount1, :amount2)
      end

    end
  end
end