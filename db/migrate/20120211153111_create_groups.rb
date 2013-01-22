# -*- encoding : utf-8 -*-
class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|

	  t.string :ident
      t.string :name

      t.timestamps
    end
  end
end
