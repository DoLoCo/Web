class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :website
      t.text :description
      t.string :address_line1
      t.string :address_line2
      t.string :city
      t.string :state
      t.string :postal_code
      t.decimal :lat, precision: 10, scale: 6
      t.decimal :lng, precision: 10, scale: 6

      t.timestamps
    end
  end
end
