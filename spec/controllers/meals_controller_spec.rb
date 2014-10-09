require "rails_helper"

describe MealsController do
  let!(:event) { Event.create name: "Startup Weekend", start_date: 1.day.from_now, end_date: 3.days.from_now }

  describe "GET index" do
    subject { get :index, event_id: event.id }

    #TODO get factory working
    # let!(:future_meal) { create :meal, start_time: 1.day.from_now }
    # let!(:past_meal  ) { create(:meal), start_time: 1.day.ago      }
    let!(:meal)  { Meal.create  name: "Dinner", head_count: 100, event: event, start_time: event.start_date }

    before { subject }

    it "renders the index template" do
      expect(response).to render_template :index
    end

    it "finds the event" do
      expect(assigns(:event)).to eq event
    end

    it "finds the events meals" do
      expect(assigns(:meals)).to include meal
    end
  end

  describe "GET new" do
    subject { get :new, event_id: event.id }

    before { subject }

    it "renders the new template" do
      expect(response).to render_template :new
    end

    it "finds the event" do
      expect(assigns(:event)).to eq event
    end
  end

  describe "POST create" do
    subject { post :create, event_id: event.id, meal: params }
    before  { subject }

    context "with valid params" do
      let(:params) { { name: "Snack", head_count: 75, start_time: event.start_date } }

      it "creates a meal for the event" do
        expect(event.reload.meals.last.name).to eq "Snack"
      end
    end

    context "with invalid params" do
      context "with missing params" do
        let(:params) { { name: nil, head_count: nil, start_time: event.start_date  } }

        it "does not create a meal" do
          expect(event.reload.meals).to be_empty
        end
      end

      context "when the start_time is not within the event timeframe" do
        let(:params) { { name: "Snack", head_count: 100, start_time: event.start_date - 1.day } }

        it "does not create a meal" do
          expect(event.reload.meals).to be_empty
        end
      end
    end
  end
end
