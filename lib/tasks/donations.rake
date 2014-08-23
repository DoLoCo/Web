namespace :donations do

  desc 'Payout any pending donations to campaigns'
  task :payout => :environment do
    Campaign.with_pending_donations.pluck(:id).each do |campaign_id|
      DonationsPayoutWorker.perform_async(campaign_id)
    end
  end

end