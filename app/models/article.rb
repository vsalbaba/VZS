class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  has_many :comments

  validates :title, :content, :user_id, :presence => true
  validates :content, :length => { :minimum => 10 }

  attr_accessible :title, :content, :user_id, :group_id, :commentable

  self.per_page = 10
end
