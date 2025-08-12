# app/constraints/event_constraint.rb
class EventConstraint
  def matches?(request)
    categories = request.path_parameters[:categories]
    event_slug = request.path_parameters[:event_slug]
    category = Category.find_by(slug: categories)

    return false unless category.present?
    category.events.exists?(slug: event_slug)
  end
end
