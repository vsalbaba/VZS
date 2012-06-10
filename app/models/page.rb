class Page < ActiveRecord::Base
  validates :title, :content, :presence => true

  attr_accessible :title, :menu_title, :content, :navbar, :menu

end
