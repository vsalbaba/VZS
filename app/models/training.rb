# -*- encoding : utf-8 -*-
class Training < ActiveRecord::Base
  auto_html_for :program do
    image
    youtube
    link
    simple_format
  end

  has_and_belongs_to_many :profiles
  validates :date, :presence => true
end
