# encoding: UTF-8

class StatisticsController < ApplicationController
  #FIXME: before_filter :login_required
  def stats
    @from_date = parse_date(params[:from_date])
    @to_date = parse_date(params[:to_date]) || Date.current
    @statistics = User.all.map {|user| Statistic.new user, :from => @from_date, :to => @to_date}
  end

  private
  def parse_date datestring
     Date.strptime(datestring, '%d. %m. %Y') if datestring.present?
  end
end

