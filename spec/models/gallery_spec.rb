# == Schema Information
# Schema version: 20121009213651
#
# Table name: galleries
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  user_id     :integer
#  group       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#  article_id  :integer
#

require 'spec_helper'

describe Gallery do
  pending "add some examples to (or delete) #{__FILE__}"
end
