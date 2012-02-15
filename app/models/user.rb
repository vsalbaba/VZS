class User < ActiveRecord::Base

  after_create :create_user_profile
  acts_as_authentic

  belongs_to :group
  has_many :articles

  has_one :profile, :dependent => :destroy
  accepts_nested_attributes_for :profile

  validates :group_id, :presence => true
  validates :login, :presence => true


  private
    def create_user_profile
      self.build_profile
    end
end
