class MealsController < ApplicationController

  def index
    @meals = Meal.where("start_time >= ?", Time.now)
  end

end
