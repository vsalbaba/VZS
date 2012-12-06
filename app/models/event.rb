class Event < ActiveRecord::Base
  auto_html_for :content do
    image
    youtube(:width => 474, :height => 300)
    link
    simple_format
  end

  has_many :brigades
  has_many :users, :through => :brigades
end
