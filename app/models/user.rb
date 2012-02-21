class User < ActiveRecord::Base
  acts_as_authentic

  belongs_to :group
  has_many :articles
  has_many :comments

  validates :group_id, :presence => true
  validates :login, :presence => true
end
