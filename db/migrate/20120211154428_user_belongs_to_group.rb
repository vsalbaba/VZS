# -*- encoding : utf-8 -*-
class UserBelongsToGroup < ActiveRecord::Migration
  def up
	  add_column :users, :group_id, :integer, :default => 1
  end

  def down
	  remove_column :users, :group_id
  end
end
