class AddPersonTextToLifeGuards < ActiveRecord::Migration
  def change
    add_column :life_guards, :person_text, :string
  end
end
