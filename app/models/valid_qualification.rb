class ValidQualification < ActiveRecord::Base
  attr_accessible :valid_from, :valid_to, :qualification, :profile, :profile_id, :qualification_id
  belongs_to :profile
  belongs_to :qualification
end