namespace :donations do

  desc 'Payout any pending donations to campaigns'
  task :payout => :environment do
    DonationsPayoutProcessor.run
  end

end