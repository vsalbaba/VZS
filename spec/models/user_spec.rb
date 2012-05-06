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

  describe 'validations' do
    it 'should allow defined groups' do
      User::GROUP.each_value do |group_id|
        should allow_value(group_id).for(:group)
      end
    end
    it 'should not allow unknown groups' do
      should_not allow_value(nil).for(:group)
      should_not allow_value(-1).for(:group)
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

  describe '#group?' do
    it 'should be true on users own group' do
      @user.group?(@user.group).should be_true
    end
    it 'should be true when group is same as users one' do
      @user.group = User::GROUP[:MEMBER]
      @user.group?(User::GROUP[:MEMBER]).should be_true
    end
    it 'should not be true when group is different to users one' do
      @user.group = User::GROUP[:OUTSIDER]
      @user.group?(User::GROUP[:MEMBER]).should_not be_true
    end
  end
end
