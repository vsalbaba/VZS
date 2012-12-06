class EventsController < ApplicationController
  before_filter :find_event, :only => ['show', 'edit', 'update', 'destroy']
  def index
    @events = Event.actual.order('date DESC')
  end

  def old
    @events = Event.old.order('date DESC')
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
  end

  def destroy
  end

  private
  def find_event
    @event = Event.find params[:id]
  end
end
