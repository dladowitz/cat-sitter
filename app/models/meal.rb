class Meal < ActiveRecord::Base
  belongs_to :event
  has_many :dishes

  validates :name, presence: true
  validates :event, presence: true
  validates :head_count, presence: true, numericality: true
  validate  :start_time_within_range

  # Seems like if name can only be breakfast, lunch, dinner or snack, then we should be
  # doing something else. Maybe lock do the column? Polymorphic? Not really sure.

  def start_time_within_range
    return unless self.start_time

    # had to add .to_i because comparing the exact same time doesn't seem to equal itself
    if self.start_time.to_i < event.start_date.to_i ||  self.start_time.to_i > event.end_date.to_i
      errors.add(:start_time, "must be with event time frame")
    end
  end
end
