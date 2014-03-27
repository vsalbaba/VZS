# -*- encoding : utf-8 -*-
class LifeGuard < ActiveRecord::Base
  attr_accessible :at, :position, :profile_id, :person_text
  belongs_to :life_guarding_timespan
  belongs_to :profile
  validates :position, :uniqueness => {:scope => :at}

  def life_guard_text
    if person_text then
      "#{person_text} (#{profile.full_name})"
    else
      profile.full_name
    end
  end
end
