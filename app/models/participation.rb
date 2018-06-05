class Participation < ActiveRecord::Base
  belongs_to :event
  belongs_to :participant, :class_name => "Profile", :foreign_key => "profile_id"
  validates :event_id, :uniqueness => {:scope => :profile_id}

  scope :no_can_dos, -> {where(participation_type: "no_can_do")}
  scope :maybes, -> {where(participation_type: "maybe")}
  scope :will_do, -> {where(participation_type: "yes")}

  def as_json
    super({:include => {:participant => {:only => [:id, :vzs_id, :first_name, :second_name, :telephone, :email], :methods => :full_name}}})
  end
end
