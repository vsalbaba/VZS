# -*- encoding : utf-8 -*-
# == Schema Information
# Schema version: 20121009213651
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  menu_title :string(255)
#  content    :text
#  navbar     :boolean
#  menu       :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Page do
  pending "add some examples to (or delete) #{__FILE__}"
end
