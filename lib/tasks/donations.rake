namespace :donations do

  desc 'Payout any pending donations to campaigns'
  task :payout => :environment do
    processor = DonationsPayoutProcessor.new
    processor.process
  end

end