class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.belongs_to :organization, index: true
      t.belongs_to :bank_account, index: true
      t.string :title
      t.text :description
      t.string :status
      t.integer :target_amount
      t.date :target_date

      t.timestamps
    end
  end
end
