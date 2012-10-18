# == Schema Information
# Schema version: 20121009213651
#
# Table name: photos
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  user_id            :integer
#  gallery_id         :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

require 'spec_helper'

describe Photo do
  pending "add some examples to (or delete) #{__FILE__}"
end
