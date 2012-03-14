class AddBirthDateToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :birthdate, :date
    add_column :profiles, :birthnumber, :integer
  end
  def down
    remove_column :profiles, :birthdate
    remove_column :progiles, :birthnumber
  end
end
