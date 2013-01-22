# -*- encoding : utf-8 -*-
class AddVzsIdToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :vzs_id, :string
    change_column :profiles, :birthnumber, :string
  end
end
