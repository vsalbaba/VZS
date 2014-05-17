class ValidQualification < ActiveRecord::Base
  attr_accessible :valid_from, :valid_to
  belongs_to :profile
  belongs_to :qualification
end