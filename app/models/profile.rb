class Profile < ActiveRecord::Base
  attr_accessible :first_name, :second_name, :street, :house_number, :city, :postal_code, :email, :telephone, :im_jabber

  belongs_to :user

  validates :first_name, :presence => :true, :on => :update
  validates :second_name, :presence => :true, :on => :update
  validates :email, :presence => :true, :on => :update
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :update
end
