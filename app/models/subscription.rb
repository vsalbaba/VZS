# encoding: UTF-8
class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :show

  validates_uniqueness_of :show_id, :scope => :user_id, :message => "Na ukázku jste již přihlášen"
  #validate :number_of_people

  scope :subscribed, :conditions => { :subscribed => true }
  scope :not_subscribed, :conditions => { :subscribed => false }

  default_scope :order => 'created_at'

  def number_of_people
    if self.subscribed and self.show.people and (self.show.subscribed_count >= self.show.people)
      errors.add(:base, "Prilis mnoho lidi na ukazce") 
    end
  end
end

