# == Schema Information
# Schema version: 20121009213651
#
# Table name: galleries
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  user_id     :integer
#  group       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#  article_id  :integer
#

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
