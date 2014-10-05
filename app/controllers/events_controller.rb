class EventsController < ApplicationController

  def index
    @upcoming_events = Event.where("start_date > ?", Time.now)
    @past_events     = Event.where("start_date < ?", Time.now)
  end

  def new
    @event = Event.new

  end

  def create
    event = Event.new(event_params)

    if event.save
      flash[:notice] = "Event Created"
    else
      flash[:error] = "You totally didn't do that right. Event not created"
    end

    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :location, :start_date, :end_date)
  end
end
