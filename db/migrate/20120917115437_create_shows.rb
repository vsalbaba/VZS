class CreateShows < ActiveRecord::Migration
  def up
    create_table :shows do |t|
      t.string :name
      t.date :date
      t.time :meet_time
      t.time :end_time
      t.integer :payed_hours
      t.integer :people
      t.string :meet_at
      t.string :contact
      t.boolean :breakfast
      t.boolean :lunch
      t.boolean :dinner
      t.boolean :club
      t.text :notes
      t.text :description
      t.boolean :paid
      t.integer :brigade_hours
      t.boolean :archived
      t.timestamps
    end
  end

  def down
    drop_table :shows
  end
end
