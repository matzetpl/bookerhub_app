module CategoryBreadcrumbHandler
  extend ActiveSupport::Concern

  def set_category_breadcrumbs
    @category.full_hierarchy_names.each do |url, name|
      add_breadcrumb(category_show_path(categories: url), name)
    end
  end
end
