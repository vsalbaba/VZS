# -*- encoding : utf-8 -*-
class EventsController < ApplicationController
  load_and_authorize_resource

  def participate
    @event.participations.where(:profile_id => current_user.profile.id).destroy_all
    participation = Participation.will_do.build(:event => @event, :participant => current_user.profile)
    participation.save!
    redirect_to events_path
  end

  def not_participate
  end

  def no_can_do
    no_can_do = Participation.no_can_dos.build(:event => @event, :participant => current_user.profile)
    no_can_do.save!
    redirect_to events_path
  end

  def unparticipate
    participant = Profile.find(params[:participant_id])
    @event.participations.where(:profile_id => participant.id).destroy_all
    redirect_to events_path
  end

  def index
    @pending_events = @events.pending.order('start_datetime ASC')
    @done_events = @events.actual.done.order('start_datetime DESC')
  end

  def old
    @events = @events.old.order('date DESC')
    render :action => "index"
  end

  def show
  end

  def new
    @event = Event.new :start_datetime => Time.now, :end_datetime => Time.now
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

  def finish
    @event = Event.find(params[:id])
    @event.finish
    redirect_to :action => 'index'
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
