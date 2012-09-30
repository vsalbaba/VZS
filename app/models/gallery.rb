class Gallery < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
  has_many :photos

  validates :name, :presence => true
  validates :user, :presence => true
  validates :group, :presence => true, :inclusion => { :in => User::GROUP.values }

  attr_accessible :name, :description, :article_id, :user_id, :group, :photos_attributes

  accepts_nested_attributes_for :photos, :allow_destroy => true
end
