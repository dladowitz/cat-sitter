class Dish < ActiveRecord::Base
  belongs_to :meal

  validates :name, presence: true

  #TODO pretty sure there is some kind of alias thing that can be done here
  def event
    meal.event
  end
end
