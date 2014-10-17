require "rails_helper"

describe MealsController do
  let(:event) { Event.create name: "Startup Weekend", start_date: 1.day.from_now, end_date: 3.days.from_now }
  let(:meal) { event.meals.create(name: "Dinner", head_count: 99, start_time: event.start_date + 1.day) }

  describe "GET index" do
    subject { get :index, event_id: event.id }

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

  describe "GET show" do
    subject { get :show, event_id: event.id, id: meal.id }
    before { subject }

    it "finds the correct meal" do
      expect(assigns(:meal)).to eq meal
    end

    it "finds the correct event" do
      expect(assigns(:event)).to eq event
    end
  end

  describe "GET edit" do
    subject { get :edit, event_id: event.id, id: meal.id }
    before { subject }

    it "finds the correct meal" do
      expect(assigns(:meal)).to eq meal
    end

    it "finds the correct event" do
      expect(assigns(:event)).to eq event
    end
  end

  describe "PATCH update" do
    subject { patch :update, params }
    before { subject }

    context "with valid params" do
      let(:params) { { event_id: event.id, id: meal.id, meal: { name: "Snack" } } }

      it "updates the meal correctly" do
        expect(meal.reload.name).to eq "Snack"
      end

      it "updates the flash correctly" do
        expect(flash[:notice]).to eq "Meal Updated."
      end
    end

    context "with invalid params" do
      let(:params) { { event_id: event.id, id: meal.id, meal:{ name: "snack", start_time: 1.year.ago } } }

      it "does not update the meal" do
        expect(meal.reload.name).to eq "Dinner"
      end

      it "has errors on the model" do
        expect(assigns(:meal).errors[:start_time]).to be_present
      end
    end
  end
end
