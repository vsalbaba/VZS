# -*- encoding : utf-8 -*-
class AddCommentableToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :commentable, :boolean
  end
end
