class RemoveAddressFromProfile < ActiveRecord::Migration
  def up
    remove_column :profiles, :street
    remove_column :profiles, :city
    remove_column :profiles, :postal_code
    remove_column :profiles, :house_number
  end

  def down
    add_column :profiles, :house_number, :string
    add_column :profiles, :postal_code, :integer
    add_column :profiles, :city, :string
    add_column :profiles, :street, :string
  end
end
