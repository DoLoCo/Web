class CreateOrganizationAdmins < ActiveRecord::Migration
  def change
    create_table :organization_admins do |t|
      t.belongs_to :user, index: true
      t.belongs_to :organization, index: true

      t.timestamps
    end
  end
end
