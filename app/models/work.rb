class Work < ActiveRecord::Base
  attr_accessible :ammount, :profile_id, :text, :work_type, :event_id
  belongs_to :event
  belongs_to :profile

end
