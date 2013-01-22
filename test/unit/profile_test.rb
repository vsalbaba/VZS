# -*- encoding : utf-8 -*-
# == Schema Information
# Schema version: 20121009213651
#
# Table name: profiles
#
#  id          :integer          not null, primary key
#  first_name  :string(255)
#  second_name :string(255)
#  email       :string(255)
#  telephone   :string(255)
#  im_jabber   :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  birthdate   :date
#  birthnumber :string(255)
#  vzs_id      :string(255)
#

require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Profile.new.valid?
  end
end
