# spec/models/category_spec.rb
require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { Category.create(name: "Category Name") }
  let(:organizer) { Organizer.create() }
  let(:location) { Location.create(name: "Location Name") }

  def create_event(category:, name:, description:, start_date:, end_date:, status:)
    event = Event.create(
      name: name,
      description: description,
      start_date: start_date,
      end_date: end_date,
      status: status,
      organizer: organizer,
      category: category
    )
    event
  end

  describe "associations" do
 

    it "has many events" do
      event = create_event(
        category: category,
        name: "Event Name",
        description: "Event Description",
        start_date: Time.zone.now + 1.day,
        end_date: Time.zone.now + 2.day,
        status: "active"
      )

      expect(category.events.count).to eq(1)
      expect(category.events).to include(event)
    end

    it "belongs to parent category" do
      parent_category = Category.create(name: "Parent Category")
      child_category = Category.create(name: "Child Category", parent: parent_category)

      expect(child_category.parent).to eq(parent_category)
    end

    it "has many children categories" do
      parent_category = Category.create(name: "Parent Category")
      child_category1 = Category.create(name: "Child Category 1", parent: parent_category)
      child_category2 = Category.create(name: "Child Category 2", parent: parent_category)

      expect(parent_category.children.count).to eq(2)
      expect(parent_category.children).to include(child_category1)
      expect(parent_category.children).to include(child_category2)
    end
        
  end

  describe "validations" do
    it "should have correct event association" do
      event = create_event(
        category: category,
        name: "Event Name",
        description: "Event Description",
        start_date: Time.zone.now + 1.day,
        end_date: Time.zone.now + 2.day,
        status: "active"
      )

      expect(category.events.first).to eq(event)
    end
        
  end
end
