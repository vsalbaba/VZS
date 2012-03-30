class User < ActiveRecord::Base
  GROUP_ADMIN = 0
  GROUP = {
    :OUTSIDER => 0,
    :MEMBER => 1,
    :BOARD => 2,
    :ADMIN => 3
  }

  after_create :create_user_profile
  acts_as_authentic

  has_many :articles
  has_many :comments

  has_one :profile, :dependent => :destroy

  accepts_nested_attributes_for :profile

  validates :group, :presence => true, :inclusion => { :in => GROUP.values }
  validates :login, :presence => true

  private
  def create_user_profile
    self.build_profile
  end
end
