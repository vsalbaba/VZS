# -*- encoding : utf-8 -*-
class Brigade < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
end
