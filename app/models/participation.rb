class Participation < ActiveRecord::Base
  belongs_to :event
  belongs_to :participant, :class_name => "Profile", :foreign_key => "profile_id"
  validates :event_id, :uniqueness => {:scope => :profile_id}
end
