class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :text
      t.integer :ammount
      t.integer :work_type
      t.integer :profile_id
      t.integer :event_id
      t.datetime :at
      t.timestamps
    end
  end
end
