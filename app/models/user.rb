# -*- encoding : utf-8 -*-
# == Schema Information
# Schema version: 20121009213651
#
# Table name: users
#
#  id                :integer          not null, primary key
#  login             :string(255)
#  crypted_password  :string(255)
#  password_salt     :string(255)
#  persistence_token :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  group             :integer
#

class User < ActiveRecord::Base

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
  has_many :attachments
  has_many :galleries
  has_many :photos
  has_many :brigades
  has_many :events, :through => :brigades

  has_one :profile, :dependent => :destroy, :inverse_of => :user

  accepts_nested_attributes_for :profile

  validates :group, :presence => true, :inclusion => { :in => GROUP.values }
  validates :login, :presence => true

  attr_accessible :login, :group,
    :password, :password_confirmation,
    :crypted_password, :password_salt, :persistence_token,
    :profile, :profile_attributes

  def self.members
    where(["`users`.`group` > ?", GROUP[:OUTSIDER]])
  end

  def is_member_or_more?
    self.group.to_i >= User::GROUP[:MEMBER]
  end

  def group?(g)
    g == self.group
  end

  def admin?
    group == GROUP[:ADMIN]
  end

  def board?
    group == GROUP[:BOARD]
  end

  def member?
    group == GROUP[:MEMBER]
  end

  def full_name
    return login if profile.nil? or ( profile.first_name.empty? and profile.second_name.empty? )
    return  profile.second_name + ' ' + profile.first_name
  end

  private
  def init_user
    self.group = GROUP[:OUTSIDER] if self.group.nil?
  end
end
