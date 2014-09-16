class BankAccountCreate

  attr_reader :params, :ownable, :bank_account

  def initialize(params, ownable)
    @params = params
    @ownable = ownable
  end

  def save!
    @bank_account = ownable.bank_accounts.build(params)

    begin
      #gateway_bank_account = Balanced::BankAccount.new(
      #  account_number: @bank_account.account_number,
      #  account_type: @bank_account.account_type,
      #  routing_number: @bank_account.routing_number,
      #  name: @ownable.name
      #).save

      # Claim the bank account via balanced (w/e that means)

      # do we get this when we "claim" the account or beforehand?
      @bank_account.gateway_reference_id = gateway_bank_account.id

      if @bank_account.save
        BankAccountVerificationWorker.perform_async(@bank_account.id)
      end

    rescue Balanced::BadRequest => ex
      @bank_account.valid? # force validations

      unless ex.error_message.nil?
        error = ex.body[:errors][0]['extras']
        @bank_account.errors.add(error.keys.first, error.values.first)
      end
    end

    @bank_account
  end

end