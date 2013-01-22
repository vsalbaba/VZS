# -*- encoding : utf-8 -*-
class ArticlesBelongsToGroup < ActiveRecord::Migration
  def up
	  add_column :articles, :group_id, :integer, :default => 1
  end

  def down
	  remove_column :articles, :group_id
  end
end
