require 'spec_helper'

describe User do
  it {should validate_presence_of :group}
  it {should validate_presence_of :login}
  describe 'creation' do
    it 'should create user and group should be outsider' do
      user = Factory :user
      user.group.should == User::GROUP[:OUTSIDER]
    end
  end
end
