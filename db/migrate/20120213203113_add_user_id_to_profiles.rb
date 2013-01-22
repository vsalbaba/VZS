# -*- encoding : utf-8 -*-
class AddUserIdToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :user_id, :integer
  end
end
