# -*- encoding : utf-8 -*-
class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :article_id
      t.integer :user_id
      t.string :name
      t.has_attached_file :file

      t.timestamps
    end
  end
end
