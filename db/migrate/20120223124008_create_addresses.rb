class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.string :area
      t.string :postcode
      t.string :land_registry_number
      t.string :house_number

      t.timestamps
    end
  end
end
