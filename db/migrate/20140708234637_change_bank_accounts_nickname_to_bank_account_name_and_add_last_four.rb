class ChangeBankAccountsNicknameToBankAccountNameAndAddLastFour < ActiveRecord::Migration
  def change
    rename_column :bank_accounts, :nickname, :bank_account_name
    add_column :bank_accounts, :last_four, :string, limit: 4
  end
end
