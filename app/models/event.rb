class Event < ActiveRecord::Base
  validates_presence_of :name, :start_date, :end_date

  has_many :meals

  #TODO add custom validation for end date being after start date

  private

  def end_date_after_start_date?
    end_date >= start_date
  end
end
