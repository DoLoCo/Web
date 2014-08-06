class BankAccountCreate

  attr_reader :params, :ownable, :bank_account

  def initialize(params, ownable)
    @params = params
    @ownable = ownable
  end

  def save!
    @bank_account = ownable.bank_accounts.build(params)

    if !@bank_account.account_number.blank?
      @bank_account.last_four = @bank_account.account_number.split(//).last(4).join
    end

    # create balancepayment bank_account
    # store gateway_reference_id from balancedpayment response
    @bank_account.gateway_reference_id = '91919-TEST'

    if @bank_account.save
      # push job for bank account verification
    end

    @bank_account
  end

end