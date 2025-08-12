# spec/models/event_schedule_ticket_spec.rb
require 'rails_helper'

RSpec.describe EventScheduleTicket, type: :model do
  it { should belong_to(:event_ticket) }
  it { should belong_to(:event_schedule) }

end
