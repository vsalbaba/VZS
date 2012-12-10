class Event < ActiveRecord::Base
  PENDING_CUTOF_IN_DAYS = 2

  auto_html_for :description do
    image
    youtube :width => 474, :height => 300
    link
    simple_format
  end

  has_many :brigades
  has_many :users, :through => :brigades

  scope :actual, where(['`events`.`start_datetime` > ?', 1.year.ago])
  scope :old, where(['`events`.`start_datetime` < ?', 1.year.ago])
  scope :pending, where(['`events`.`start_datetime` > ?', PENDING_CUTOF_IN_DAYS.days.ago])
  scope :done, where(['`events`.`start_datetime` < ?', PENDING_CUTOF_IN_DAYS.days.ago])
end
