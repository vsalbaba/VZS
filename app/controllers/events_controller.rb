# -*- encoding : utf-8 -*-
class EventsController < ApplicationController
  load_and_authorize_resource

  def participate
    @event.participants << current_user.profile
    redirect_to events_path
  end

  def not_participate
  end

  def index
    @pending_events = @events.pending.order('start_datetime ASC')
    @done_events = @events.actual.done.order('end_datetime DESC')
  end

  def old
    @events = @events.old.order('date DESC')
    render :action => "index"
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new params[:event]
    if @event.save
      redirect_to events_path
    else
      render :action => "new"
    end
  end

  def edit
  end

  def update
    @event.attributes = params[:event]
    if @event.save
      redirect_to @event, :notice => flash_message(:update, @event)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url, :notice => flash_message(:destroy, @event)
  end
end
