require 'spec_helper'

describe User do
  it {should validate_presence_of :group}
  it {should validate_presence_of :login}
  describe 'creation' do
    it 'should create and save profile for new user' do
      user = Factory :user
      user.profile.id.should_not be_nil
    end
  end
end
