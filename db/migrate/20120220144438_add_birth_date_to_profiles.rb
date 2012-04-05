class AddBirthDateToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :birthdate, :date
    add_column :profiles, :birthnumber, :integer
  end
end
