require File.dirname(__FILE__) + '/../spec_helper'

describe Address do

  before :each do
    @address = Factory :address
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
end
  


