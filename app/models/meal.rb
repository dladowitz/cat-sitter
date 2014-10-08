class Meal < ActiveRecord::Base
  belongs_to :event
  # has_many :dishes

  validates :name, presence: true
  validates :event, presence: true
  validates :head_count, presence: true, numericality: true

  # Seems like if name can only be breakfast, lunch, dinner or snack, then we should be
  # doing something else. Maybe lock do the column? Polymorphic? Not really sure.
end
