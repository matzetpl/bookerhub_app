class CategoriesController < BaseController
  include CategoryBreadcrumbHandler

  def show
    set_category
    category_ids = @category.self_and_descendants_ids
    @pagy, @events_objects = pagy(Event.where(category_id: category_ids), limit: 10)
  end

  private

  def set_index_breadcrumb
    add_breadcrumb categories_path, "Categories"
  end

  def set_category
    @category = Category.find_by(slug: params[:categories])
    set_category_breadcrumbs
  end
end
