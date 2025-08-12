module Slugable
  extend ActiveSupport::Concern

  included do
    before_validation :set_slug
    before_update :update_slug_if_changed

    validates :slug, presence: true, uniqueness: true
  end


  private

  def set_slug
    return if self.slug.present? || self.name.blank?
    self.slug = generate_unique_slug
  end

  # def generate_slug
  #   self.source_column.parameterize
  # end

  def generate_unique_slug
    base_slug = self.source_column.parameterize # Use the source_column as per your code
    unique_slug = base_slug

    # If the slug already exists, append a random string to make it unique
    count = 1
    while self.class.exists?(slug: unique_slug)
      unique_slug = "#{base_slug}-#{SecureRandom.hex(4)}" # Append a random hex string
      count += 1
    end

    unique_slug
  end

  def update_slug_if_changed
    # Check if the source_column has changed
    if saved_changes.include?(source_column)
      self.slug = generate_unique_slug
    end
  end
end
