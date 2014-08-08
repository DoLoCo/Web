class BankAccountVerificationWorker
  include Sidekiq::Worker

  def perform(bank_account_id)
    bank_account = BankAccount.find(bank_account_id)
    
    if bank_account.unverified?
      gateway_ba = Balanced::BankAccount.fetch("/bank_accounts/#{bank_account.gateway_reference_id}")  
      verification = gateway_ba.verify

      if verification && verification['bank_account_verifications'][0]['verification_status'] == 'pending'
        bank_account.verification_created!
      else
        self.perform_async(bank_account_id)
      end
    end
  end
end