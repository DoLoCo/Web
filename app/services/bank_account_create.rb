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

    gateway_bank_account = Balanced::BankAccount.new(
      account_number: @bank_account.account_number,
      account_type: @bank_account.account_type,
      routing_number: @bank_account.routing_number,
      name: @ownable.name
    ).save

    # TODO: handle errors, didn't show up in the documentation need to dig around
    @bank_account.gateway_reference_id = gateway_bank_account['bank_accounts'][0]['id']

    if @bank_account.save
      BankAccountVerificationWorker.perform_async(@bank_account.id)
    end

    @bank_account
  end

end