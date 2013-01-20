# == Schema Information
# Schema version: 20121009213651
#
# Table name: photos
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  user_id            :integer
#  gallery_id         :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Photo < ActiveRecord::Base
  belongs_to :gallery
  belongs_to :user
  before_validation :setname_before_validation

  attr_accessible :name, :image, :user, :gallery_id

  has_attached_file :image, :styles => {:thumbnail => '90x90#',
                                        :gallery => '120x120#',
                                        :small => '260x120>',
                                        :medium => '260x180>',
                                        :large => '800x600>',
                                        :original => '1680x1680>'},
                            :convert_options => { :all => '-auto-orient' }

  validates_attachment_presence :image

  def file_name
    image_file_name
  end
  def size
    image_file_size
  end

  private
  def setname_before_validation
    if (name.nil? or name.empty?) and not (file_name.nil? or file_name.empty?)
      self[:name] = file_name
    end
  end
end
