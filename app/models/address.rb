class Address < ActiveRecord::Base
  attr_accessible :street, :house_number, :city, :postcode, :profile_id

  belongs_to :profile
end
