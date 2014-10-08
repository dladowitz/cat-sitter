require "rails_helper"

describe MealsController do
  describe "GET index" do
    subject { get :index }

    #TODO get factory working
    # let!(:future_meal) { create :meal, start_time: 1.day.from_now }
    # let!(:past_meal  ) { create(:meal), start_time: 1.day.ago      }
    let!(:event)       { Event.create name: "Startup Weekend" }
    let!(:future_meal) { Meal.create name: "Dinner", start_time: 1.day.from_now, head_count: 100, event: event }
    let!(:past_meal  ) { Meal.create name: "Dinner", start_time: 1.day.ago,      head_count: 100, event: event }

    before { subject }

    it "should render the index template" do
      expect(response).to render_template :index
    end

    it "should find all upcoming meals" do
      expect(assigns(:meals)).to include future_meal
      expect(assigns(:meals)).to_not include past_meal
    end
  end
end
