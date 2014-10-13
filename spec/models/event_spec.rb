require "rails_helper"

describe Event do

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:end_date) }
  it { should_not validate_presence_of(:location) }
  it { should have_many :meals }

  it "creates an Event object" do
    event = Event.new name: "Startup Weekend"
    expect(event).to be_a Event
  end

  it "has a valid factory" do
    event = create :event
    expect(event).to be_a Event
  end

  it "saves to the database" do
    expect { Event.create name: "Startup Weekend", start_date: 1.day.from_now, end_date: 3.days.from_now }.to change{Event.count}.by 1
  end

  context "when end date is before start date" do
    let(:event) { Event.new name: "Startup Weekend", start_date: Time.now, end_date: 1.day.ago }

    it "the event is not valid" do
      expect(event.valid?).to eq false
    end

    it "has errors on the end date" do
      event.save
      expect(event.errors.messages[:end_date].first).to eq "must be after start date. (Unless you have a Flux Capacitor)."
    end
  end
end
