# -*- encoding : utf-8 -*-
class LifeGuard < ActiveRecord::Base
  attr_accessible :at, :position, :profile_id
  belongs_to :life_guarding_timespan
  belongs_to :profile
  validates :position, :uniqueness => {:scope => :at}

  def life_guard_text
    if profile then
      profile.full_name
    else
      person_text
    end
  end
end
