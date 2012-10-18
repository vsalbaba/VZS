# == Schema Information
# Schema version: 20121009213651
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  article_id :integer
#  user_id    :integer
#  message    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Comment.new.valid?
  end
end
