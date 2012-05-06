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
    it 'should equal itself' do
      @address.==(@address).should be_true
    end

    it 'should equal address with same attributes' do
      second_address = Factory :address
      second_address.street = @address.street
      second_address.house_number = @address.house_number
      second_address.city = @address.city
      second_address.postcode = @address.postcode

      @address.==(second_address).should be_true
    end
      
    it 'should not equal when street varies' do
      second_address = Factory :address, :street => 'rozdilna ulice'
      @address.==(second_address).should_not be_true
    end
    it 'should not equal when city varies' do
      second_address = Factory :address, :city => 'rozdilne mesto'
      @address.==(second_address).should_not be_true
    end
    it 'should not equal when house number varies' do
      second_address = Factory :address, :house_number => '42jina'
      @address.==(second_address).should_not be_true
    end
    it 'should not equal when postcode varies' do
      second_address = Factory :address, :postcode => '86869'
      @address.==(second_address).should_not be_true
    end
  end
end
  


