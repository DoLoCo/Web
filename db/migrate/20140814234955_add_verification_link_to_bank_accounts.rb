class AddVerificationLinkToBankAccounts < ActiveRecord::Migration
  def change
    add_column :bank_accounts, :verification_link, :string
  end
end
