class Profile < ActiveRecord::Base
  after_create :create_address
  attr_accessible :first_name, :second_name, 
    :email, :telephone,
    :im_jabber, :birthdate,
    :birthnumber, :address_id, :address_attributes

  belongs_to :user
  has_one :address, :dependent => :destroy
  accepts_nested_attributes_for :address

  validates :first_name, :presence => :true
  validates :second_name, :presence => true
  validates :user, 
    :presence => true

  validates :email, 
    :presence => true, 
    :format => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
    :if => :is_member_or_more?

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

  private
  def create_address
    self.build_address
  end
  def is_member_or_more?
    if user.nil?  or user.group.nil?
      return false
    end
    user.group.id > 1 
  end
end

