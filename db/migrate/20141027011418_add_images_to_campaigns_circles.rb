class AddImagesToCampaignsCircles < ActiveRecord::Migration
  def change
    add_column :campaigns, :image_url, :string, default: ""
    add_column :organizations, :image_url, :string, default: ""
  end
end
