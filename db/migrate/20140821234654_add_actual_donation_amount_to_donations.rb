class AddActualDonationAmountToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :actual_amount, :integer
  end
end
