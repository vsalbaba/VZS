require 'spec_helper'

describe Profile do
  before :each do 
    @profile = Factory :profile 
  end

  it 'should be valid when age equal to 10' do
    @profile.birthdate = 10.years.ago
    @profile.user_age.should eq 10
  end

  it 'should be valid when age is not equal 10' do
    @profile.birthdate = 12.years.ago
    @profile.user_age.should_not eq 10
  end

  it 'should be valid when user_age is false' do
    @profile.birthdate = nil
    @profile.user_age.should eq false
  end
end
