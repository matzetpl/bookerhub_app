class CategoryConstraint
  def matches?(request)
    categories = request.path_parameters[:categories]
    Category.exists?(slug: categories)
  end
end