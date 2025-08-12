class Organization < ApplicationRecord
  belongs_to :admin
  has_many :events
end
