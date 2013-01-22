# -*- encoding : utf-8 -*-
class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :name
      t.references :user
      t.references :gallery

      t.timestamps
    end
    add_index :photos, :user_id
  end
end
