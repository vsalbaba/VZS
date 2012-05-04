require 'spec_helper'

describe User do
  it {should validate_presence_of :group}
  it {should validate_presence_of :login}

  before :each do
    @user = Factory :user
  end

  describe 'creation' do
    it 'should create user and group should be outsider' do
      @user.group.should == User::GROUP[:OUTSIDER]
    end
  end

  describe '#is_member_or_more?' do
    it 'should be false when user is not a member' do
      @user.group = User::GROUP[:OUTSIDER]
      @user.is_member_or_more?.should_not be_true
    end
    it 'should be true when user is a member' do
      @user.group = User::GROUP[:MEMBER]
      @user.is_member_or_more?.should be_true
    end
    it 'should be true when user is a member of board' do
      @user.group = User::GROUP[:BOARD]
      @user.is_member_or_more?.should be_true
    end
    it 'should be true when user is a administrator' do
      @user.group = User::GROUP[:ADMIN]
      @user.is_member_or_more?.should be_true
    end
  end
end
