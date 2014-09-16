class BankAccountsController < ApplicationController
  # authenticate

  def new
    @bank_account = BankAccount.new
  end

  def create
    @bank_account = BankAccount.new(bank_account_params)
    @bank_account.ownable = current_user
    @bank_account.save
    respond_with(@bank_account)
  end

private

  def bank_account_params
    params.require(:bank_account).permit(*policy(@bank_account || BankAccount).permitted_attributes)
  end

end