require 'rails_helper'
RSpec.describe "Events", type: :request do
  let(:organizer) { Organizer.create() }
  let(:category) { Category.create(name: "Category Name") }
  let(:nested_category) { Category.create(name: "Nested Category", parent_id: category.id) }
  let(:event) { Event.create(
    name: "Event Name",
    organizer: organizer,
    description: "Event Description",
    start_date: Time.zone.now + 1.day,
    end_date: Time.zone.now + 2.days,
    status: "active",
    category: category
  ) }
  let(:nested_event) { Event.create(
    category: nested_category,
    name: "Nested Event Name",
    organizer: organizer,
    description: "Event Description",
    start_date: Time.zone.now + 1.day,
    end_date: Time.zone.now + 2.days,
    status: "active"
  )}

  describe "GET /:categories" do
    it "returns a successful response for category" do
      get "/#{category.slug}"

      expect(response).to have_http_status(:success)
    end

    it "returns a successful response for nested category" do
      get "/#{nested_category.slug}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /:categories/:event_slug" do
    it "returns a successful response for event" do
      get "/#{category.slug}/#{event.slug}"
      expect(response).to have_http_status(:success)
    end

    it "returns a successful response for nested event" do
      get "/#{nested_category.slug}/#{nested_event.slug}"
      expect(response).to have_http_status(:success)
    end
  end
end
