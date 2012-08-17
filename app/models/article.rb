class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :attachments
  has_one :gallery

  validates :title, :content, :user_id, :presence => true
  validates :content, :presence => true
  validates :group, :presence => true, :inclusion => { :in => User::GROUP.values }

  attr_accessible :title, :content, :user_id, :group, :commentable

  self.per_page = 10
end
