class Qualification < ActiveRecord::Base
  has_many :profiles, :through => :valid_qualifications
  has_many :valid_qualifications
  attr_accessible :name, :description, :abbreviation
end