# -*- encoding : utf-8 -*-
class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.string :first_name
      t.string :second_name
      t.string :street
      t.string :house_number
      t.string :city
      t.integer :postal_code
      t.string :email
      t.string :telephone
      t.string :im_jabber
      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
