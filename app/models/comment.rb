class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user

  validates :article_id, :user_id, :message, :presence => true

  attr_accessible :article_id, :user_id, :message
end
