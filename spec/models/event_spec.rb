# spec/models/event_spec.rb
require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:organizer) { Organizer.create() }
  let(:category) { Category.create(name: "Category Name") }

  describe "associations" do
    it "belongs to organizer" do
      event = Event.new(name: "Event Name", organizer: organizer)
      expect(event.organizer).to eq(organizer)
    end

    it "belongs to category" do
      event = Event.new(name: "Event Name", category: category)
      expect(event.category).to eq(category)
    end
  end

  describe "validations" do
    it "is valid with valid attributes" do
      event = Event.new(
        name: "Event Name",
        organizer: organizer,
        description: "Event Description",
        start_date: Time.zone.now + 1.day,
        end_date: Time.zone.now + 2.days,
        status: "active",
        category: category
      )
      expect(event).to be_valid
    end

    it "is not valid without a name" do
      event = Event.new(
        organizer: organizer,
        description: "Event Description",
        start_date: Time.zone.now + 1.day,
        end_date: Time.zone.now + 2.days,
        status: "active"
      )
      expect(event).to_not be_valid
      expect(event.errors[:name]).to include("can't be blank")
    end

    it "is not valid without a category" do
      event = Event.new(
        name: "Event Name",
        description: "Event Description",
        start_date: Time.zone.now + 1.day,
        end_date: Time.zone.now + 2.days,
        status: "active"
      )
      expect(event).to_not be_valid
      expect(event.errors[:category]).to include("must exist")
    end

    it "is not valid without a description" do
      event = Event.new(
        name: "Event Name",
        organizer: organizer,
        start_date: Time.zone.now + 1.day,
        end_date: Time.zone.now + 2.days,
        status: "active"
      )
      expect(event).to_not be_valid
      expect(event.errors[:description]).to include("can't be blank")
    end

    it "is not valid without a start_date" do
      event = Event.new(
        name: "Event Name",
        organizer: organizer,
        description: "Event Description",
        end_date: Time.zone.now + 2.days,
        status: "active"
      )
      expect(event).to_not be_valid
      expect(event.errors[:start_date]).to include("can't be blank")
    end

    it "is not valid without an end_date" do
      event = Event.new(
        name: "Event Name",
        organizer: organizer,
        description: "Event Description",
        start_date: Time.zone.now,
        status: "active"
      )
      expect(event).to_not be_valid
      expect(event.errors[:end_date]).to include("can't be blank")
    end

    it "is not valid with a start_date in the past" do
      event = Event.new(
        name: "Event Name",
        organizer: organizer,
        description: "Event Description",
        start_date: Time.zone.now - 1.day,
        end_date: Time.zone.now + 2.days,
        status: "active"
      )
      expect(event).to_not be_valid
      expect(event.errors[:start_date]).to include("can't be in the past")
    end

    it "is not valid with an end_date before the start date" do
      event = Event.new(
        name: "Event Name",
        organizer: organizer,
        description: "Event Description",
        start_date: Time.zone.now + 2.days,
        end_date: Time.zone.now + 1.day,
        status: "active"
      )
      expect(event).to_not be_valid
      expect(event.errors[:end_date]).to include("must be after the start date")
    end

    it "is not valid without a status" do
      event = Event.new(
        name: "Event Name",
        organizer: organizer,
        description: "Event Description",
        start_date: Time.zone.now,
        end_date: Time.zone.now + 2.days,
        status: nil
      )
      expect(event).to_not be_valid
      expect(event.errors[:status]).to include("can't be blank")
    end
  end

  describe "status enum" do
    it "defaults to draft" do
      event = Event.new(
        name: "Test Event",
        organizer: organizer,
        description: 'desc',
        start_date: Time.zone.now + 1.day,
        end_date: Time.zone.now + 2.days     
      )
      expect(event.status).to eq("draft")
      expect(event.draft?).to be true
    end

    it "can transition to different statuses" do
      event = Event.new(
        name: "Test Event",
        organizer: organizer,
        description: 'desc',
        start_date: Time.zone.now + 1.day,
        end_date: Time.zone.now + 2.days,
        status: :draft,
        category: category
      )
      event.active!
      expect(event.status).to eq("active")
      expect(event.active?).to be true

      event.canceled!
      expect(event.status).to eq("canceled")
      expect(event.canceled?).to be true

      event.completed!
      expect(event.status).to eq("completed")
      expect(event.completed?).to be true
    end


  end
end
