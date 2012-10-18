# == Schema Information
# Schema version: 20121009213651
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  article_id :integer
#  user_id    :integer
#  message    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user

  validates :article_id, :user_id, :message, :presence => true

  attr_accessible :article_id, :user_id, :message
end
