# spec/models/event_schedule_spec.rb
require 'rails_helper'

RSpec.describe EventSchedule, type: :model do
  it { should belong_to(:event) }
  it { should belong_to(:location) }
  it { should have_many(:event_schedule_tickets) }
end