# == Schema Information
# Schema version: 20121009213651
#
# Table name: articles
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  content     :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  commentable :boolean
#  group       :integer
#  sticky      :boolean
#  approved    :boolean
#

class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :attachments
  has_one :gallery

  validates :title, :content, :user_id, :presence => true
  validates :content, :presence => true
  validates :group, :presence => true, :inclusion => { :in => User::GROUP.values }

  attr_accessible :title, :content, :user_id, :group, :commentable, :sticky

  self.per_page = 10

  def to_param
    self.id.to_s + "-" + title.parameterize
  end

end
