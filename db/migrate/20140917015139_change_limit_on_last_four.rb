class ChangeLimitOnLastFour < ActiveRecord::Migration
  def up
    change_column :bank_accounts, :last_four, :string, :limit => 50
  end

  def down
    change_column :bank_accounts, :last_four, :string, :limit => 4
  end
end
