# -*- encoding : utf-8 -*-
class LifeGuardsController < ApplicationController
  before_filter :find_life_guarding_timespan
  respond_to :html, :js
  load_and_authorize_resource

  def index
  end

  def show
    @life_guard = @life_guarding_timespan.life_guards.find(params[:id])
  end

  def new
    @life_guard = @life_guarding_timespan.life_guards.new params[:life_guard]
  end

  def create
    if @life_guarding_timespan.save
      redirect_to @life_guarding_timespan, :notice => flash_message(:create, @life_guarding_timespan)
    else
      render :action => "new"
    end
  end

  def subscribe
    @life_guard = @life_guarding_timespan.life_guards.new params[:life_guard]
    @life_guard.at = params[:date]
    @life_guard.position = params[:position]
    if params[:user] then
      @life_guard.profile = User.find(params[:user]).profile
    else
      @life_guard.profile = current_user.profile
    end
    @life_guard.save!
    respond_with @life_guard
  end

  def unsubscribe
    @life_guard.destroy
    redirect_to @life_guarding_timespan
  end

  def edit

  end

  def update

  end

  def destroy
  end

  private

  def find_life_guarding_timespan
    @life_guarding_timespan = LifeGuardingTimespan.find(params[:life_guarding_timespan_id])
  end
end
