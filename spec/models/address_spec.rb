require File.dirname(__FILE__) + '/../spec_helper'

describe Address do

  before :each do
    @address = Factory :address_for_member
  end

  describe 'validations' do
    it 'should not be valid without street' do
      @address.street = nil
      @address.should_not be_valid
      @address.errors[:street].should_not be_blank
    end

    it 'should not be valid without house_number' do
      @address.house_number = nil
      @address.should_not be_valid
      @address.errors[:house_number].should_not be_blank
    end

    it 'should not be valid without city' do
      @address.city = nil
      @address.should_not be_valid
      @address.errors[:city].should_not be_blank
    end

    it 'should not be valid without postcode' do
      @address.postcode = nil
      @address.should_not be_valid
      @address.errors[:postcode].should_not be_blank
    end
  end

  describe '#is_member_or_more?' do
    it 'should be false when addres has no profile' do
      @address.profile = nil
      @address.is_member_or_more?.should_not be_true
    end
    it 'should be true when address has a profile which belongs to a member' do
      @address.profile.user.group = User::GROUP[:MEMBER]
      @address.is_member_or_more?.should be_true
    end
  end

  describe 'address equality comparison' do
    it 'should equal itself'
    it 'should equal address with same attributes'
    it 'should not equal when street varies'
    it 'should not equal when city varies'
    it 'should not equal when house number varies'
    it 'should not equal when postcode varies'
  end
end
  


