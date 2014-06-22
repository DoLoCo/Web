class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.belongs_to :user, index: true
      t.belongs_to :bank_account, index: true
      t.belongs_to :campaign, index: true
      t.integer :amount

      t.timestamps
    end
  end
end
