# -*- encoding : utf-8 -*-
class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :article_id
      t.integer :user_id
      t.text :message
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
