class User < ActiveRecord::Base
  acts_as_authentic

  belongs_to :group
  has_many :articles

  validates :group_id, :presence => true
  validates :login, :presence => true
end
