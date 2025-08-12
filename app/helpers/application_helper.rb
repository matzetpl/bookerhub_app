module ApplicationHelper
  include Pagy::Frontend

  def event_show_path_helper(event)
    return "#" if event.slug.nil?
    event_show_path(categories: event.category_slug, event_slug: event.slug)
  end

  def display_layout_data(key_name: nil)
    return "" unless key_name.present?

    @layout_data[key_name.to_sym] rescue ""
  end
end
