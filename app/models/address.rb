class Address < ActiveRecord::Base
  attr_accessible :street, :house_number, :city, :postcode, :profile_id

  belongs_to :profile

  validates :street, :presence => true
  validates :house_number, :presence => true
  validates :city, :presence => true
  validates :postcode, :presence => true

end
