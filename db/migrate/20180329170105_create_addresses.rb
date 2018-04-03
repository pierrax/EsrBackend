class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :business_name
      t.string :address_1
      t.string :address_2
      t.string :zip_code
      t.string :city
      t.string :country
      t.string :phone
      t.float :latitude
      t.float :longitude
      t.date :date_start
      t.date :date_end
      t.integer :status, default: 1
      t.integer :addressable_id
      t.string  :addressable_type

      t.timestamps
    end

    add_index :addresses, [:addressable_type, :addressable_id]
  end
end
