# encoding: UTF-8
class Statistic
  attr_reader :user, :to, :from, :shows
  def initialize(user, options = {})
    @user = user
    @to = options[:to]
    @from = options[:from]

    @shows = @user.shows.where(:subscriptions => {:user_id => @user.id, :subscribed => true})
    if @to then
      @shows = @shows.where('date <= :to', :to => @to)
    end
    if @from then
      @shows = @shows.where('date >= :from', :from => @from)
    end
  end

  def paid_hours
    return @paid_hours if @paid_hours
    @paid_hours = @shows.where(:subscriptions => {:wants_payed => true}).sum(:payed_hours)
  end

  def brigade_hours
    return @brigade_hours if @brigade_hours
    @brigade_hours = @shows.where(:subscriptions => {:wants_payed => nil}).sum(:brigade_hours)
  end

  def pay
    paid_hours * Show::HOUR_RATE
  end
end
