# spec/models/event_ticket_spec.rb
require 'rails_helper'

RSpec.describe EventTicket, type: :model do
  it { should belong_to(:event) }
  it { should have_many(:event_schedule_tickets) }
end
