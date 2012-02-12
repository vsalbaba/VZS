class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  validates :title, :content, :user_id, :presence => true
  validates :content, :length => { :minimum => 10 }

  attr_accessible :title, :content, :user_id, :group_id
end
