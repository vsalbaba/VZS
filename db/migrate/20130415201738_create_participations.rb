class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.integer :event_id
      t.integer :profile_id
      t.integer :position
      t.timestamps
    end
  end
end
