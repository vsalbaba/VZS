class CreateLifeGuards < ActiveRecord::Migration
  def change
    create_table :life_guards do |t|
      t.integer :life_guarding_timespan_id
      t.integer :profile_id
      t.integer :position
      t.date :at

      t.timestamps
    end
  end
end
