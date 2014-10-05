class EventsController < ApplicationController

  def index
    @upcoming_events = Event.where("start_date > ?", Time.now)
    @past_events     = Event.where("start_date < ?", Time.now)
  end

  def create
    if Event.create(event_params)
      flash[:message] = "Event Created"
    else
      flash[:message] = "You did it wrong. The event wasn't created"
    end
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:name, :location, :start_date, :end_date)
  end
end
