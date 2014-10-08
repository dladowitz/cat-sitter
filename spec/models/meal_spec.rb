require "rails_helper"

describe Meal do

  it { should belong_to :event  }
  # it { should have_many :dishes } #TODO create dishes
  it { should validate_presence_of :name }
  it { should validate_presence_of :head_count }
  it { should validate_numericality_of :head_count }
  it { should validate_presence_of :event }

  it "should have a valid factory" do
    meal = create(:meal)
    expect(meal).to be_instance_of Meal
  end
end
