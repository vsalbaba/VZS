# -*- encoding : utf-8 -*-
# == Schema Information
# Schema version: 20121009213651
#
# Table name: profiles
#
#  id          :integer          not null, primary key
#  first_name  :string(255)
#  second_name :string(255)
#  email       :string(255)
#  telephone   :string(255)
#  im_jabber   :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  birthdate   :date
#  birthnumber :string(255)
#  vzs_id      :string(255)
#

class Profile < ActiveRecord::Base
  attr_accessible :first_name, :second_name,
    :email, :telephone,
    :im_jabber, :birthdate,
    :birthnumber,
    :address, :address_attributes, :vzs_id
  audited
  belongs_to :user, :inverse_of => :profile
  has_and_belongs_to_many :trainigs
  has_many :qualifications, :through => :valid_qualifications
  has_many :valid_qualifications
  has_one :address, :dependent => :destroy, :inverse_of => :profile
  accepts_nested_attributes_for :address

  def self.sorted_members
    joins(:user).where("`users`.`group` > 0").order("second_name ASC, first_name ASC")
  end

  validates :address,
    :presence => true,
    :if => :is_member_or_more?

  validates :first_name, :presence => true
  validates :second_name, :presence => true

  validates :user, :presence => true
  validates :user_id, :uniqueness => true

  validates :email, :format => /\A(([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,}))?\Z/i

  validates :telephone,
    :presence => true,
    :if => :is_member_or_more?

  validates :birthdate,
    :presence => true,
    :if => :is_member_or_more?

  validates :birthnumber,
    :presence => :true,
    :if => :is_member_or_more?
  def participates?(event)
    !event.participants.where("profile_id" => self.id).empty?
  end
  def user_age
    return nil if birthdate.nil?
    now = Time.now.utc.to_date
    now.year - birthdate.year - ((now.month > birthdate.month || (now.month == birthdate.month && now.day >= birthdate.day)) ? 0 : 1)
    #(Time.now.to_date - birthdate.to_date).to_i / 365
  end

  def user_age_group
    if user_age.to_i < 15
      return :younger15
    elsif user_age.to_i < 18
      return :younger18
    end
    return :adults
  end

  def is_member_or_more?
    user and user.is_member_or_more?
  end

  def full_name
    [second_name, first_name].join " "
  end

  def email_address
    "\"#{full_name}\" <#{email}>" unless email.blank?
  end
end

