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

  describe "GET new" do
    subject { get :new }
    before  { subject }

    it "renders the new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    subject { post :create, event: params }

    context "with valid params" do
      let(:params) { { name: "Angel Hack", location: "Moscone", start_date: 1.day.from_now, end_date: 3.days.from_now } }

      it "returns http success" do
        subject
        expect(response).to redirect_to events_path
      end

      it "creates a new event" do
        expect { subject }.to change{Event.count}.by 1
      end

      it "sets the flash correctly" do
        subject
        expect(flash[:notice]).to eq "Event Created"
      end
    end

    context "with invalid params" do
      let(:params) { { name: nil } }

      it "returns http success" do
        subject
        expect(response).to redirect_to events_path
      end

      it "does not create a new event" do
        expect { subject }.to_not change{Event.count}
      end

      it "sets the flash correctly" do
        subject
        expect(flash[:error]).to eq "You totally didn't do that right. Event not created"
      end
    end
  end

  describe "GET show" do
    context "when event is found in database" do
      let!(:event) { Event.create(name: "Railsbridge workshop") }
      subject { get :show, { id: event.id } }
      before { subject }

      it "finds event" do
        expect(assigns(:event)).to eq event
      end
    end

    context "when event is not in database" do
      subject { get :show, { id: "not a real id" } }
      before { subject }

      it "doesn't find the event" do
        expect(assigns(:event)).to be_nil
      end

      it "redirects to the index page" do
        expect(response).to redirect_to events_path
      end

      it "has a flash error" do
        expect(flash[:error]).to eq "Nope, not gonna god it. No such event."
      end
    end
  end

  describe "GET edit" do
    let(:event) { Event.create name: "AWS RE:Invent" }
    before { subject }

    context "when the event is in the database" do
      subject { get :edit, id: event.id }

      it "renders the edit templte" do
        expect(response).to render_template :edit
      end

      it "shows the correct event" do
        expect(assigns(:event)).to eq event
      end
    end

    context "when the event is not in the database" do
      subject { get :edit, id: "not a real event id" }

      it "redirects to the index page" do
        expect(response).to redirect_to events_path
      end

      it "sets the flash" do
        expect(flash[:error]).to eq "Event Not Found."
      end
    end


  end

  describe "PATCH update" do
    context "when event is found in Daatabase" do
      let!(:event) { Event.create(name: "Startup Weekend")}
      before { subject }

      context "with valid params" do
        subject { patch :update, { id: event.id, event: { name: "Railsbridge" } } }

        it "updates the event" do
          expect(event.reload.name).to eq "Railsbridge"
        end

        it "sets the flash" do
          expect(flash[:notice]).to eq "Event Updated."
        end
      end

      context "with invalid params" do
        subject { patch :update, { id: event.id, event: { name: nil } } }

        it "does not update the event" do
          expect(event.name).to eq "Startup Weekend"
        end

        it "sets the flash" do
          expect(flash[:error]).to eq "That's not how we do it here. Event not updated."
        end
      end
    end

    context "when event is not found in Database" do
      let!(:event) { Event.create(name: "Startup Weekend")}
      subject { patch :update, { id: "not a real event id", event: { name: "Railsbridge" } } }
      before { subject }

      it "redirects to the index page" do
        expect(response).to redirect_to events_path
      end

      it "sets the flash" do
        expect(flash[:error]).to eq "Event Not Found."
      end
    end
  end
end


