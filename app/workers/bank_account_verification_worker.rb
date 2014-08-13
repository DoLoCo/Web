class BankAccountVerificationWorker
  include Sidekiq::Worker

  def perform(bank_account_id)
    bank_account = BankAccount.find(bank_account_id)
    
    if bank_account.unverified?
      begin
        gateway_ba = Balanced::BankAccount.fetch("/bank_accounts/#{bank_account.gateway_reference_id}") 
        gateway_ba.verify

        bank_account.verification_created!
      rescue Balanced::Error => e
        self.perform_async(bank_account_id)
      end
    end
  end
end