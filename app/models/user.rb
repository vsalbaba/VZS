class User < ActiveRecord::Base
  #attr_accessible :login, :password
  acts_as_authentic
end
