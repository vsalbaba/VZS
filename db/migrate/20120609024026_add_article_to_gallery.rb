# -*- encoding : utf-8 -*-
class AddArticleToGallery < ActiveRecord::Migration
  def change
    add_column :galleries, :article_id, :integer
  end
end
