class CategorySyncService
  def initialize(file_path)
    @file_path = file_path
  end

  def sync_categories
    categories = load_categories
    sync_categories_recursive(nil, categories)
  end

  private

  def sync_categories_recursive(parent, categories)

    categories.each do |category_attrs|
      slug = category_attrs['slug']
      parent_slug = category_attrs['parent_slug']

      category = Category.find_or_initialize_by(slug: slug)
      category.update(category_attrs.except('parent_slug')) # Update attributes except 'parent_slug'

      # If a parent was provided and it's not the root category, find the parent by slug
      if parent_slug.present? && parent_slug != 'nil'
        parent_category = Category.find_by(slug: parent_slug)
        category.parent = parent_category if parent_category
      elsif parent.present? # If no parent_slug, but parent is provided, set the parent
        category.parent = parent
      end

      # If the category was newly created or updated, save it
      if !category.save
        raise category.errors.inspect
        raise 'not saved'
      end
    end
  end

  def load_categories
    YAML.load_file(@file_path)['categories']
  end
end
