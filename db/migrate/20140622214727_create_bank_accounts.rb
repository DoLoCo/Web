class CreateBankAccounts < ActiveRecord::Migration
  def change
    create_table :bank_accounts do |t|
      t.string :nickname
      t.string :gateway_reference_id

      t.integer :ownable_id
      t.string :ownable_type

      t.timestamps
    end
  end
end
