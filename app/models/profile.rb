class Profile < ActiveRecord::Base
  attr_accessible :first_name, :second_name, :street, :house_number, :city, :postal_code, :email, :telephone, :im_jabber, :birthdate, :birthnumber

  belongs_to :user

  validates :first_name, :second_name, :email, :presence => :true
  validates :street, :house_number, :city, :postal_code, :email, :telephone, :birthdate, :birthnumber, :presence => :true, :if => :is_member_or_more?
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  private
    def is_member_or_more?
      user.group.id > 1
    end
end

