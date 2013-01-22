# -*- encoding : utf-8 -*-
# == Schema Information
# Schema version: 20121009213651
#
# Table name: attachments
#
#  id                :integer          not null, primary key
#  article_id        :integer
#  user_id           :integer
#  name              :string(255)
#  file_file_size    :integer
#  file_file_name    :string(255)
#  file_updated_at   :datetime
#  file_content_type :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'spec_helper'

describe Attachment do
  pending "add some examples to (or delete) #{__FILE__}"
end
