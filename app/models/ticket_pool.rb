# app/models/event.rb

class TicketPool < ApplicationRecord
  belongs_to :event_location

  enum :ticket_type, { normal: "normal", pass: "pass" }, default: "normal"

  validates :name, presence: true
  validates :capacity, presence: true
  validates :valid_from, :valid_until, :ticket_date_from, :ticket_date_to, presence: true

  def self.ticket_types_options_for_select
    TicketPool.ticket_types.keys.map { |status| [ status.humanize, status ] }
  end

  # Check if the ticket pool is buyable (the current date should be within ticket and valid dates and there should be capacity)
  def buyable?
    current_date = Time.zone.now
    # Check if the ticket pool is within the valid time range and there is available capacity
    current_date.between?(valid_from, valid_until) && capacity_left > 0
  end

  # Simulate capacity used for development purposes
  # This method should calculate the capacity used based on your system logic
  def capacity_used
    rand(0..self.capacity)
  end

  # Calculate remaining capacity (if sold tickets are tracked)
  def capacity_left
    capacity - capacity_used
  end
end
