class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :attachments

  validates :title, :content, :user_id, :presence => true
  validates :content, :length => { :minimum => 10 }
  validates :group, :presence => true, :inclusion => { :in => User::GROUP.values }

  attr_accessible :title, :content, :user_id, :group, :commentable

  self.per_page = 10
end
