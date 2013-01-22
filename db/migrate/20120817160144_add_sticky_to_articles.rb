# -*- encoding : utf-8 -*-
class AddStickyToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :sticky, :boolean
  end
end
