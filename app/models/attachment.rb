# -*- encoding : utf-8 -*-
# == Schema Information
# Schema version: 20121009213651
#
# Table name: attachments
#
#  id                :integer          not null, primary key
#  article_id        :integer
#  user_id           :integer
#  name              :string(255)
#  file_file_size    :integer
#  file_file_name    :string(255)
#  file_updated_at   :datetime
#  file_content_type :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

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
