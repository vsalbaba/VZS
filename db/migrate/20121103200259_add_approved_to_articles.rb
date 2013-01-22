# -*- encoding : utf-8 -*-
class AddApprovedToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :approved, :boolean
  end
end
