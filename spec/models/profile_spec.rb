require 'spec_helper'

describe Profile do
  describe 'validate_age' do
    it 'validate age' do
      profile = Factory :profile
      profile.user_age.should eq 10
      profile = Factory :profile, :birthdate => 12.years.ago
      profile.user_age.should_not eq 10
    end
  end
end
