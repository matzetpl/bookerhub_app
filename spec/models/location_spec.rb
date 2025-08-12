# spec/models/location_spec.rb

require 'rails_helper'

RSpec.describe Location, type: :model do
  let(:location) { Location.create(name: "Location Name") }

  describe "associations" do
    it "has many events through event_schedule" do
      event = Event.create(
        name: "Event Name",
        description: "Event Description",
        start_date: Time.zone.now,
        end_date: Time.zone.now + 1.day,
        status: "active"
      )
      event_location = EventSchedule.create(location: location, event: event)
      expect(location.events).to include(event)
    end

    it "has many event_schedule" do
      event_schedule = EventSchedule.create(location: location)
      expect(location.event_schedule).to include(event_schedule)
    end
  end

  describe "validations" do
    it "is valid with valid attributes" do
      expect(location).to be_valid
    end

    it "is not valid without a name" do
      location_without_name = Location.new
      expect(location_without_name).to_not be_valid
      expect(location_without_name.errors[:name]).to include("can't be blank")
    end
  end
end
