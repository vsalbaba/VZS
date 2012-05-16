class Attachment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user

  attr_accessible :name, :file, :user_id, :article_id

  has_attached_file :file

  validates :name, :presence => true
  validates_attachment_presence :file
  validates :user_id, :presence => true
  validates :article_id, :presence => true


  def file_name
    file_file_name
  end
  def size
    file_file_size
  end
end
