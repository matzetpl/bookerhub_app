class EventsController < BaseController
  include CategoryBreadcrumbHandler

  before_action :set_obj, only: [:show]
  
  def show
    add_breadcrumb nil, @event.name
  end

  private

  def set_obj
    @category = Category.find_by(slug: params[:categories])
    @event = @category.events.find_by(slug: params[:event_slug])
    set_category_breadcrumbs
  end
end
  