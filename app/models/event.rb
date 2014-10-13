class Event < ActiveRecord::Base
  validates_presence_of :name, :start_date, :end_date
  validate :end_date_after_start_date?

  has_many :meals

  #TODO add custom validation for end date being after start date

  private

  def end_date_after_start_date?
    if end_date && end_date <= start_date
      errors.add(:end_date, "must be after start date. (Unless you have a Flux Capacitor).")
    end
  end
end
