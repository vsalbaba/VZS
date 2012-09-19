class User < ActiveRecord::Base

  GROUP = {
    :OUTSIDER => 0,
    :MEMBER => 1,
    :BOARD => 2,
    :ADMIN => 3
  }

  after_initialize :init_user
  acts_as_authentic

  has_many :articles
  has_many :comments
  has_many :attachments
  has_many :galleries
  has_many :photos
  has_many :subscriptions
  has_many :shows, :through => :subscriptions

  has_one :profile, :dependent => :destroy, :inverse_of => :user

  accepts_nested_attributes_for :profile

  validates :group, :presence => true, :inclusion => { :in => GROUP.values }
  validates :login, :presence => true

  attr_accessible :login, :group,
    :password, :password_confirmation,
    :crypted_password, :password_salt, :persistence_token,
    :profile, :profile_attributes

  def is_member_or_more?
    self.group.to_i >= User::GROUP[:MEMBER]
  end

  def group?(g)
    g == self.group
  end

  def full_name
    return login if profile.nil? or ( profile.first_name.empty? and profile.second_name.empty? )
    return  profile.second_name + ' ' + profile.first_name
  end

  def subscribed_to?(show)
    subscription = self.subscriptions.find(:first, :conditions => {:show_id => show.id})
    if subscription then
      subscription.subscribed
    else
      nil
    end
  end

  private
  def init_user
    self.group = GROUP[:OUTSIDER] if self.group.nil?
  end
end
