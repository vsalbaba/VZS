# encoding: UTF-8
require 'spec_helper'

describe Show do
  it 'should have valid factory' do
    @show = Factory :show
    @show.should be_valid
  end
end
