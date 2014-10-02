require "spec_helper"

describe "Event" do
  it "creates an Event object" do
    # binding.pry
    event = Event.new name => "Startup Weekend"   #fix hash style
  end

  it "saves to the database" do
    Event.create :name => "Startup Weekend"
    expect(Event.count).to eq 1
  end
end