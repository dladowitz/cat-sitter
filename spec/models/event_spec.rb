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

  it "must have an end date that is after the start date" do
    event = Event.new name: "Startup Weekend", start_date: Time.now, end_date: 1.day.ago
    expect(event.save).to be_false
  end
end
