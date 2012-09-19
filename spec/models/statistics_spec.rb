require 'spec_helper'

describe Statistic do
  context '#paid_hours' do
    before :each do
      @user = Factory :user
      @shows = [Factory(:show, :payed_hours => 10, :paid => true),
               Factory(:show, :payed_hours => 20, :paid => true, :date => 10.days.ago)]

      @shows.each do |show|
        Factory :subscription, :user => @user, :show => show, :wants_payed => true
      end
    end

    it 'should sum all paid hours without set from' do
      stats = Statistic.new @user
      stats.paid_hours.should == 30
    end

    it 'should sum all hours from date if from is set' do
      stats = Statistic.new @user, :from => 5.days.ago
      stats.paid_hours.should == 10
    end

    it 'should sum all hours to date if to is set' do
      stats = Statistic.new @user, :to => 5.days.ago
      stats.paid_hours.should == 20
    end

    it 'should sum all hours in range if :from and :to are set' do
      stats = Statistic.new @user, :from => 5.days.ago, :to => 3.days.ago
      stats.paid_hours.should == 0
    end

    it 'should count only subscriptions which user wanted paid' do
      @shows << Factory(:show, :payed_hours => 5, :paid => true)
      Factory :subscription, :user => @user, :show => @shows.last, :wants_payed => false
      stats = Statistic.new @user
      stats.paid_hours.should == 30
    end
  end

  context '#brigade_hours' do
     before :each do
      @user = Factory :user
      @shows = [Factory(:show, :payed_hours => 10, :paid => false),
               Factory(:show, :payed_hours => 20, :paid => false, :date => 10.days.ago)]

      @shows.each do |show|
        Factory :subscription, :user => @user, :show => show
      end
    end   
     
    it 'should sum all brigade hours' do
      stats = Statistic.new @user
      stats.brigade_hours.should == 30
    end  

    it 'should sum all brigade' do
    end
  end
end
