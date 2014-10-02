require "rails_helper"

describe "Event" do
  it "creates an Event object" do
    event = Event.new name: "Startup Weekend"
  end

  it "saves to the database" do
    expect { Event.create name: "Startup Weekend" }.to change{Event.count}.by(1)
  end
end