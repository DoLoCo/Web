class DonationsPayoutWorker
  include Sidekiq::Worker

  def perform(campaign_id)
    campaign = Campaign.find(campaign_id)
    bank_account = campaign.bank_account

    # find all of the pending donations
    donations = campaign.donations.pending

    # calculate the total amount to credit campaign's bank account
    total_donation_amount = donations.sum(:actual_amount)

    # don't attempt to process credit if there's nothing to credit
    # probably shouldn't happen, but just in case
    return unless total_donation_amount > 0

    begin
      # credit bank account
      gateway_bank_account = Balanced::BankAccount.fetch("/bank_accounts/#{bank_account.gateway_reference_id}")

      gateway_bank_account.credit(
        amount: total_donation_amount,
        appears_on_statement_as: 'DoLoCoDonation'
      )

      # update all of the donations' statuses to 'Processed'
      donations.update_all(status: Donation::STATUSES[:processed])
    rescue Balanced::Error => e
      # TODO log error
    end
  end

end