# app/models/event.rb

class EventLocation < ApplicationRecord
  belongs_to :event
  has_many :ticket_pools, dependent: :destroy


  scope :future, -> { where("date > ?", Time.now) }
end
