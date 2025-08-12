# app/models/category.rb
class Category < ApplicationRecord
    include Slugable

    belongs_to :parent, class_name: "Category", optional: true
    has_many :children, class_name: "Category", foreign_key: "parent_id"

    has_many :events
    validates :name, presence: true
    before_save :update_nested_slugs


    def self_and_descendants_ids
      [ id ] + children.flat_map(&:self_and_descendants_ids)
    end

    def destroy
      raise "Deletion of categories is not allowed."
    end

    def source_column
        self.name
    end

    def generate_slug
        base_slug = self.name.parameterize
        if parent.present?
          parent_slug = parent.slug
          base_slug = "#{parent_slug}/#{base_slug}"
        end
        base_slug
    end

    def update_nested_slugs
        if saved_change_to_parent_id?
          new_parent = parent
          descendants.each do |descendant|
            descendant.update_column(:slug, descendant.generate_slug)
          end
        end
    end

    def full_hierarchy_names
        if parent
            parent.full_hierarchy_names.merge({ slug => name })
        else
            { slug => name }
        end
    end
end
