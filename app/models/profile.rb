class Profile < ActiveRecord::Base
  attr_accessible :first_name, :second_name, 
    :email, :telephone,
    :im_jabber, :birthdate,
    :birthnumber,
    :address, :address_attributes, :vzs_id

  belongs_to :user, :inverse_of => :profile

  has_one :address, :dependent => :destroy, :inverse_of => :profile
  accepts_nested_attributes_for :address
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

  def user_age 
    return nil if birthdate.nil?
    (Time.now.to_date - birthdate.to_date).to_i / 365
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

end

