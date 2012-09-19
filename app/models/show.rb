# encoding: UTF-8
class Show < ActiveRecord::Base
  attr_accessible :name, :date, :meet_time, :end_time,
                  :payed_hours, :people, :meet_at, :contact, :breakfast,
                  :lunch, :dinner, :notes, :description, :paid, :archived,
                  :brigade_hours, :club

  scope :archived, :conditions => {:archived => true}
  scope :unarchived, :conditions => {:archived => nil}
  scope :club, :conditions => {:club => true}

  validates_presence_of :name, :date

  has_many :users, :through => :subscriptions
  has_many :subscriptions
  before_save :check_hours
  HOUR_RATE = 30

  def check_hours
    logger.debug "brigade_hours #{brigade_hours.inspect}"
    self[:brigade_hours] ||= payed_hours
    logger.debug "brigade_hours #{brigade_hours.inspect}"
  end

  def subscribed_count
    self.subscriptions.find_all_by_subscribed(true).size
  end

  def archive
    self.archived = true
  end

  def unarchive
    self.archived = nil
  end

  def archived?
    self.archived
  end


  def pay
    payed_hours.to_i * HOUR_RATE
  end
end


