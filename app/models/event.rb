# app/models/event.rb

class Event < ApplicationRecord
  include Slugable
  include Elasticable
  extend Pagy::ElasticsearchRails

  searchable_fields :name
  searchable_fuzziness "AUTO"

  has_one_attached :image

  belongs_to :organization
  belongs_to :category, optional: true

  has_many :event_locations, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true

  validates :status, presence: true

  scope :by_organization, -> { where(organization_id: CurrentOrganization.organization_id).where.not(organization_id: nil) }
  scope :by_active, -> { where(status: "active") }


  scope :with_valid_ticket_pool_near_today, ->(time_range = 30.days) do
    current_date = Time.zone.now.to_date  # Get the current date (ignores time)
    start_date = current_date - time_range.to_i.days # Date range start (30 days ago)
    end_date = current_date + time_range.to_i.days # Date range end (30 days from now)

    joins(event_locations: :ticket_pools)
      .where(ticket_pools: { valid_from: start_date..end_date })
      .distinct
  end

  # enum :status, [
  #   :draft,
  #   :active,
  #   :canceled,
  #   :completed
  # ], default: :draft

  enum :status, { draft: "draft", active: "active", canceled: "canceled", completed: "completed" }, default: "draft"

  def self.status_options_for_select
    Event.statuses.keys.map { |status| [ status.humanize, status ] }
  end

  def closest_date
    self.event_locations.order(date: :asc).first&.date
  end


  settings do
    mappings dynamic: false do
      indexes :name, type: "text"
      indexes :slug, type: "text"
      indexes :category_slug, type: "text"

      # Add more fields as needed
    end
  end

  def as_indexed_json(_options = {})
  {
    name: name,
    slug: slug,
    category_slug: category_slug

    # Add more fields as needed
  }
  end

  def category_slug
    self.category.slug if self.category.present?
  end

  def source_column
    self.name
  end

  def start_date
  end

  def end_date
  end
end
