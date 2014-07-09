module Api
  module V1
    module User
      class BankAccountsController < Api::ApplicationController
        before_action :authenticate

        set_pagination_headers :bank_accounts, only: [:index]

        def index
          @bank_accounts = current_user.bank_accounts.paginate(page: params[:page], per_page: 10)
          respond_with(@bank_accounts)
        end

        def show
          respond_with(current_user.bank_accounts.find(params[:id]))
        end

        def create
          @bank_account = current_user.bank_accounts.build
        end

        def update
          
        end

        def destroy
          
        end

      end
    end
  end
end