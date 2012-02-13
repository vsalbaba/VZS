class User < ActiveRecord::Base
  acts_as_authentic

  belongs_to :group
  has_many :articles

  has_one :profile
  accepts_nested_attributes_for :profile

  #validates :group_id, :presence => true
  validates :login, :presence => true
end
