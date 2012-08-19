class Photo < ActiveRecord::Base
  belongs_to :gallery
  belongs_to :user
  before_validation :setname_before_validation

  attr_accessible :name, :image, :user, :gallery_id

  has_attached_file :image, :styles => {:thumbnail => '90x90#', :gallery => '120x120#', :small => '260x120>', :medium => '260x180>', :large => '800x600>' }

  validates_attachment_presence :image
  validates :user, :presence => true

  def file_name
    image_file_name
  end
  def size
    image_file_size
  end

  private
  def setname_before_validation
    if name.empty? and not file_name.empty?
      self[:name] = file_name
    end
  end
end
