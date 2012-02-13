class Profile < ActiveRecord::Base
  attr_accessible :first_name, :second_name, :street, :house_number, :city, :postal_code, :email, :telephone, :im_jabber

  belongs_to :user
end
