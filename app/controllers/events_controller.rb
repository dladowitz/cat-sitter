class EventsController < ApplicationController

  def index
    @upcoming_events = Event.where("start_date > ?", Time.now)
    @past_events     = Event.where("start_date < ?", Time.now)
  end
end
