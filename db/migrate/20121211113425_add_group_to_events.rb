# -*- encoding : utf-8 -*-
class AddGroupToEvents < ActiveRecord::Migration
  def change
    add_column :events, :group, :integer
  end
end
