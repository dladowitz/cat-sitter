require "rails_helper"

describe EventsController do
  describe "GET index" do
    subject { get :index }

    it "renders the index template" do
      subject
      expect(response).to render_template :index
    end

    context "when there are only upcoming events" do
      before  { Event.create(name: "Startup Weekend", location: "The Hub", start_date: 1.day.from_now) }

      it "shows upcoming events" do
        subject
        expect(assigns(:upcoming_events).count).to eq 1
        expect(assigns(:past_events).count).to eq 0
      end
    end

    context "when there are only past events" do
      before  { Event.create(name: "Startup Weekend", location: "The Hub", start_date: 1.day.ago) }

      it "shows past events" do
        subject
        expect(assigns(:past_events).count).to eq 1
        expect(assigns(:upcoming_events).count).to eq 0
      end
    end

    context "when there are both past and future events" do
      before  { Event.create(name: "Startup Weekend", location: "The Hub", start_date: 1.day.from_now) }
      before  { Event.create(name: "Startup Weekend", location: "The Hub", start_date: 1.day.ago) }

      it "shows upcoming and past events" do
        subject
        expect(assigns(:upcoming_events).count).to eq 1
        expect(assigns(:past_events).count).to eq 1
      end
    end
  end

  describe "POST Create" do
    subject { post :create, event: { name: "Launch", location: "Moscone", start_date: 1.day.from_now, end_date: 3.days.from_now } }

    it "returns http success" do
      subject
      expect(response).to redirect_to events_path
    end

    it "creates a new event" do
      expect { subject }.to change{Event.count}.by 1
    end

    it "sets the flash correctly" do
      subject
      expect(flash[:message]).to eq "Event Created"
    end
  end
end


