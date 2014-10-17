require "rails_helper"

describe DishesController do
  let(:dish)  { create :dish }
  let(:meal)  { dish.meal }
  let(:event) { dish.event }
  before  { subject }

  describe "GET index" do
    subject { get :index, meal_id: meal.id, event_id: event.id }

    it "renders the index template" do
      expect(response).to render_template :index
    end

    it "finds the dish, meal and event" do
      expect(assigns(:dishes)).to include dish
      expect(assigns(:meal)).to eq meal
      expect(assigns(:event)).to eq event
    end
  end

  describe "POST create" do
    subject { post :create, params }

    context "with valid params" do
      let(:params) { { meal_id: meal.id, event_id: event.id, dish: { name: "Salmon", vegan: false } } }

      it "creates a dish" do
        expect(meal.dishes.last.name).to eq "Salmon"
      end

      it "sets the flash" do
        expect(flash[:notice]).to eq "Dish created. You best save me some."
      end
    end

    context "with invalid params" do
      it "doesn't create a dish" do
        let(:params) { { meal_id: meal.id, event_id: event.id, dish: { name: nil, vegan: false } } }

        expect(flash[:])
      end
    end
  end

  describe "GET show" do
    subject { get :show, id: dish.id, meal_id: meal.id, event_id: event.id }

    it "renders the show template" do
      expect(response).to render_template :show
    end

    it "finds the correct dish, meal and event" do
      expect(assigns(:dish)).to eq dish
      expect(assigns(:meal)).to eq meal
      expect(assigns(:event)).to eq event
    end
  end

  describe "GET edit" do
    subject { get :edit, id: dish.id, meal_id: meal.id, event_id: event.id }

    it "renders the edit template" do
      expect(response).to render_template :edit
    end

    it "finds the correct dish, meal and event" do
      expect(assigns(:dish)).to eq dish
      expect(assigns(:meal)).to eq meal
      expect(assigns(:event)).to eq event
    end
  end
end
