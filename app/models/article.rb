class Article < ActiveRecord::Base
  belongs_to :user

  validates :title, :content, :user_id, :presence => true
  validates :content, :length => { :minimum => 10 }

  attr_accessible :title, :content, :user_id
end
