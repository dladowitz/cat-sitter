class MealsController < ApplicationController
  before_filter :load_event
  before_filter :load_meal, only: [:show, :edit, :update]

  def index
    @meals = @event.meals
  end

  def new
    @meal = @event.meals.new
  end

  def create
    meal = @event.meals.create meal_params
    if meal.errors.any?
      @meal = meal
      render :new
    else
      redirect_to event_path @event
    end
  end

  def show
  end

  def edit
  end

  def update
    if @meal.update(meal_params)
      flash[:notice] = "Meal Updated."
      redirect_to event_meal_path(@event, @meal)
    else
      render :edit
    end
  end

  private

  def meal_params
    params.require(:meal).permit(:event_id, :name, :head_count, :start_time)
  end

  def load_event
    @event = Event.find(params[:event_id])
  end

  def load_meal
    @meal = @event.meals.where(id: params[:id]).first
  end
end
