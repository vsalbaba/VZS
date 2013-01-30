# -*- encoding : utf-8 -*-
class LifeGuardingTimespan < ActiveRecord::Base
  attr_accessible :from, :to
  has_many :life_guards
  accepts_nested_attributes_for :life_guards, :allow_destroy => true

  validates_presence_of :from
  validates_presence_of :to
  def self.current
    current_year = Date.current.year
    all.select{|e| e.from.year == current_year}.first
  end

  def dates
    from..to
  end

  def people_at(date)
    life_guards.where(:at => date).order("position DESC")
  end
end
