class CreateApartments < ActiveRecord::Migration
  def change
    create_table :apartments do |t|
      t.string :street_one
      t.string :street_two
      t.string :city
      t.string :postal_code
      t.string :state
      t.string :country
      t.string :contact_name
      t.string :contact_phone
      t.string :contact_hours

      t.timestamps null: false
    end
  end
end
