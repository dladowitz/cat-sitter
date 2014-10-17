class DishesController < ApplicationController
  before_filter :load_event_and_meal
  before_filter :load_dish, only: [:show, :edit, :update]
  def index
    @dishes = @meal.dishes
  end

  def show
  end

  def create
    if @dish = @meal.dishes.create(dish_params)
      flash[:notice] = "Dish created. You best save me some."
      redirect_to event_meal_path(@event, @meal)
    else
      render :new
    end
  end

  def edit
  end

  private

  def load_event_and_meal
    @event = Event.find(params[:event_id])
    @meal = @event.meals.where(id: params[:meal_id]).first
  end

  def load_dish
    @dish = @meal.dishes.where(id: params[:id]).first
  end

  def dish_params
    params.require(:dish).permit(:name, :vegetarian, :vegan, :gluten_free, :external_vendor, :meal_id)
  end
end
