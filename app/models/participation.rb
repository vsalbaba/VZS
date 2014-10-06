class Participation < ActiveRecord::Base
  belongs_to :event
  belongs_to :participant, :class_name => "Profile", :foreign_key => "profile_id"
  validates :event_id, :uniqueness => {:scope => :profile_id}

  scope :no_can_dos, -> {where(participation_type: "no_can_do")}
  scope :maybes, -> {where(participation_type: "maybe")}
  scope :will_do, -> {where(participation_type: "yes")}
end
