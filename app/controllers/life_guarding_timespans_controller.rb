# -*- encoding : utf-8 -*-
class LifeGuardingTimespansController < ApplicationController
  load_and_authorize_resource
  def current
    @life_guarding_timespan = LifeGuardingTimespan.current
  end

  def index
  end

  def show
    @life_guards = @life_guarding_timespan.life_guards
  end

  def new
    
  end

  def create
    if @life_guarding_timespan.save
      redirect_to @life_guarding_timespan, :notice => flash_message(:create, @life_guarding_timespan)
    else
      render :action => "new"
    end
  end

  def edit

  end

  def update
    if @life_guarding_timespan.update_attributes params[:life_guarding_timespan]
      redirect_to @life_guarding_timespan, :notice => flash_message(:create, @life_guarding_timespan)
    else
      render :action => "edit"
    end
  end

  def destroy
  end
end
