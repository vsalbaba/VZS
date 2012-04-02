class User < ActiveRecord::Base
  GROUP_ADMIN = 0
  GROUP = {
    :OUTSIDER => 0,
    :MEMBER => 1,
    :BOARD => 2,
    :ADMIN => 3
  }

  after_initialize :init_user
  acts_as_authentic

  has_many :articles
  has_many :comments

  has_one :profile, :dependent => :destroy, :inverse_of => :user

  accepts_nested_attributes_for :profile

  validates :group, :presence => true, :inclusion => { :in => GROUP.values }
  validates :login, :presence => true

  attr_accessible :login, :group,
    :crypted_password, :password_salt, :persistence_token,
    :profile, :profile_attributes

  def is_member_or_more?
    self.group.to_i >= User::GROUP[:MEMBER]
  end

  private
  def init_user
    self.build_profile if self.profile.nil?
    self.group = GROUP[:OUTSIDER] if self.group.nil?
  end
end
