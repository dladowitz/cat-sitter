class EventsController < ApplicationController

  def index #TODO push lookup to private method
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
    else #TODO should really be surfacing errors from the model, not create custom flash
      flash[:error] = "You totally didn't do that right. Event not created"
    end

    redirect_to events_path
  end

  def show
    unless @event = Event.find_by_id(params[:id])
      flash[:error] = "Nope, not gonna do it. No such event."
      redirect_to events_path
    end
  end

  def edit
    @event = Event.find_by_id(params[:id])

    unless @event
      flash[:error] = "Event Not Found."
      redirect_to events_path
    end
  end

  def update  #TODO refactor method
    if @event = Event.find_by_id(params[:id])
      if @event.update(event_params)
        flash[:notice] = "Event Updated."
        redirect_to @event
      else #TODO should really be surfacing errors from the model, not create custom flash
        flash[:error] = "That's not how we do it here. Event not updated."
        redirect_to @event
      end
    else
      flash[:error] = "Event Not Found."
      redirect_to events_path
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :location, :start_date, :end_date)
  end
end
