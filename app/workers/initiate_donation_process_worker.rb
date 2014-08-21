class InitiateDonationProcessWorker
  include Sidekiq::Worker

  def perform(donation_id)
    donation = Donation.find(donation_id)

    # don't debit twice!
    return unless donation.status == Donation::STATUSES[:initiated]

    campaign = donation.campaign
    user_bank_account = donation.bank_account

    begin
      gateway_bank_account = Balanced::BankAccount.fetch("/bank_accounts/#{user_bank_account.gateway_reference_id}")

      gateway_bank_account.debit(
        amount: donation.amount,
        appears_on_statement_as: "DoLoCoDonation",
        description: "Donation to #{campaign.organization.name} - #{campaign.title}"
      )

      # calculate actual donation amount after fees
      # Fee is 1% + $0.30 processing debits
      # and $0.25 for processing credits
      donation.actual_amount = (donation.amount - (donation.amount * 0.01)) - 55

      donation.status = Donation::STATUSES[:pending]
      donation.save
    rescue Balanced::Error => e
      # TODO log error
    end
  end

end