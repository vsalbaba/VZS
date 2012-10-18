# == Schema Information
# Schema version: 20121009213651
#
# Table name: articles
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  content     :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  commentable :boolean
#  group       :integer
#  sticky      :boolean
#  approved    :boolean
#

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Article.new.valid?
  end
end
