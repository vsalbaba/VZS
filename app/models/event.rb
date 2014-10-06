# -*- encoding : utf-8 -*-
class Event < ActiveRecord::Base
  PENDING_CUTOF_IN_DAYS = 2

  auto_html_for :description do
    image
    youtube :width => 474, :height => 300
    link
    simple_format
  end
#  has_many :no_can_do_people, :through => :no_can_dos, :class_name => "Profile", :foreign_key => "profile_id"
  has_many :participations
  validates :name, :presence => true
  validates :group, :presence => true, :inclusion => {:in => User::GROUP.values}
  validates :start_datetime,
            :presence => true
  belongs_to :responsible_person,
             :class_name => "Profile"

  scope :actual, where(['`events`.`start_datetime` > ?', 1.year.ago])
  scope :old, where(['`events`.`start_datetime` < ?', 1.year.ago])
  scope :pending, where(['`events`.`start_datetime` > ?', PENDING_CUTOF_IN_DAYS.days.ago])
  scope :done, where(['`events`.`start_datetime` < ?', PENDING_CUTOF_IN_DAYS.days.ago])

  def no_can_dos
    participations.no_can_dos
  end

  def participants
    participations.will_do
  end

  def maybes
    participations.maybes
  end

  def finish
    update_attributes(:finished => true)
  end
end
