require 'spec_helper'

describe Profile do
  it {should validate_presence_of :user}
  it {should validate_presence_of :first_name}
  it {should validate_presence_of :second_name}

  before :each do 
    @profile = Factory :profile 
  end

  describe 'validations' do
    it 'should be unique to user (one user, one profile)' do
      user = Factory :user
      old_profile = Factory :profile, :user => user #TODO neni validni factory pro profil.
      @profile.user = user
      @profile.save.should_not be_true
    end

    context 'when user is member or more' do
      before(:each) do 
        @profile.stub(:is_member_or_more?).and_return(true)
      end

      it 'mock should be working' do
        @profile.send(:is_member_or_more?).should be_true
      end

      it 'should not be valid without birthnumber' do
        @profile.birthnumber = nil
        @profile.should_not be_valid
        @profile.errors[:birthnumber].should_not be_blank
      end

      it 'should not be valid without date of birth' do 
        @profile.birthdate = nil
        @profile.should_not be_valid
        @profile.errors[:birthdate].should_not be_blank
      end
      it 'should not be valid without phone number' do
        @profile.telephone = nil
        @profile.should_not be_valid
        @profile.errors[:telephone].should_not be_blank
      end
      it 'should be valid without email' do
        @profile.email = nil
        @profile.should be_valid
        @profile.errors[:email].should be_blank
      end
      it 'should not be valid without address'
    end

    context 'when user is not a member' do
      before (:each) do
        @profile.stub(:is_member_or_more?).and_return false
        @profile.send(:is_member_or_more?).should be_false
      end
      it 'should be valid without birhtnumber' do
        @profile.birthnumber = nil
        @profile.valid? #vyhodnotit validaci, jinak jsou errors vzdy emtpy
        @profile.errors[:birthnumber].should be_blank
      end
      it 'should be valid without date of birth' do

        @profile.birthdate = nil
        @profile.valid? #vyhodnotit validaci, jinak jsou errors vzdy emtpy
        @profile.errors[:birthdate].should be_blank
      end
      it 'should be valid without phone number' do
        @profile.telephone = nil
        @profile.valid? #vyhodnotit validaci, jinak jsou errors vzdy emtpy
        @profile.errors[:telephone].should be_blank
      end
      it 'should be valid without email' do
        @profile.email = nil
        @profile.valid? #vyhodnotit validaci, jinak jsou errors vzdy emtpy
        @profile.errors[:email].should be_blank
      end
      it 'should be valid without address'
    end
  end
  describe '#user_age' do
    it 'should return number of years from birthdate when birthdate is given' do
      @profile.birthdate = 10.years.ago
      @profile.user_age.should  == 10
    end

    it 'should return nil when birthdate is nil' do
      @profile.birthdate = nil
      @profile.user_age.should be_nil
    end
  end

  describe '#user_age_group' do
    it 'should return :younger15 when age is nil' do
      @profile.birthdate = nil
      @profile.user_age_group.should == :younger15
    end

    it 'should return :younger15 when age is lower then 15' do
      @profile.birthdate = 10.years.ago
      @profile.user_age_group.should == :younger15
    end

    it 'should return :younger18 when age is equal to 15' do
      @profile.birthdate = 15.years.ago
      @profile.user_age_group.should == :younger18
    end

    it 'should return :younger18 when age is lower then 18' do
      @profile.birthdate = 17.years.ago
      @profile.user_age_group.should == :younger18
    end

    it 'should return :adults when age equal to 18' do
      @profile.birthdate = 18.years.ago
      @profile.user_age_group.should == :adults
    end

    it 'should return :adults when age is greater then 18' do
      @profile.birthdate = 999.years.ago
      @profile.user_age_group.should == :adults
    end
  end

  describe '#is_member_or_more?' do
    it 'should be false when profile has no user' do
      @profile.user = nil
      @profile.is_member_or_more?.should_not be_true
    end
    it 'should be true when profile has a user which is a member' do
      @profile.user.group = User::GROUP[:MEMBER]
      @profile.is_member_or_more?.should be_true
    end
  end

  describe '#full_name' do
    it 'should return concatenation of first and second name'
    # fixme: incomplete spec
    # consider moving UsersHelper#full_name to User
    # model and better spec coverage of this method
  end
end
