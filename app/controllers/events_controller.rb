class EventsController < ApplicationController
  before_filter :find_event, :only => ['show', 'edit', 'update', 'destroy']
  def index
    @events = Event.pending.order('start_datetime DESC')
    @done_events = Event.actual.done.order('end_datetime DESC')
  end

  def old
    @events = Event.done.order('date DESC')
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

  private
  def find_event
    @event = Event.find params[:id]
  end
end
