module Api
  module V1
    module Personal
      class BankAccountsController < Api::ApplicationController
        before_action :authenticate
        before_action :load_bank_account, only: [:show, :destroy]

        set_pagination_headers :bank_accounts, only: [:index]

        def index
          @bank_accounts = current_user.bank_accounts.paginate(page: params[:page], per_page: 10)
          respond_with(@bank_accounts)
        end

        def show
          respond_with(@bank_account)
        end

        def create
          bank_account_create = BankAccountCreate.new(bank_account_params, current_user)
          @bank_account = bank_account_create.save!
          
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

        def load_bank_account
          @bank_account ||= current_user.bank_accounts.find(params[:id])
        end

      end
    end
  end
end