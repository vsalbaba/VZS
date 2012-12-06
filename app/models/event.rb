class Event < ActiveRecord::Base
  auto_html_for :description do
    image
    youtube(:width => 474, :height => 300)
    link
    simple_format
  end

  has_many :brigades
  has_many :users, :through => :brigades

  scope :actual, where(['`events`.`date` > ?', 1.year.ago])
  scope :old, where(['`events`.`date` < ?', 1.year.ago])

end
