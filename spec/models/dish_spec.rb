require "rails_helper"

describe Dish do
  it { should belong_to :meal }
  # it { should have_many :ingredients } #TODO add ingredients
  it { should validate_presence_of :name }

  let(:dish) { create :dish }

  it "has a valid factory" do
    expect(dish).to be_a Dish
  end

  describe "#event" do
    it "can call event directly" do
      expect(dish.event).to be_a Event
    end
  end

end

