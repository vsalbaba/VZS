# -*- encoding : utf-8 -*-
class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description

      t.timestamps
    end

    create_table :brigades do |t|
      t.integer :event_id
      t.integer :user_id
      t.integer :hours

      t.timestamps
    end
  end
end
