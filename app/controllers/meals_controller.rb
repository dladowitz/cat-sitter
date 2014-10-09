class MealsController < ApplicationController
  before_filter :load_event

  def index
    @meals = @event.meals
  end

  def new
    @meal = @event.meals.new
  end

  def create
    @event.meals.create meal_params
    redirect_to event_path @event
  end

  private

  def meal_params
    params.require(:meal).permit(:event_id, :name, :head_count, :start_time)
  end

  def load_event
    @event = Event.find(params[:event_id])
  end
end
