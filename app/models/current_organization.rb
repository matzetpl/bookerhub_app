class CurrentOrganization < ActiveSupport::CurrentAttributes
  attribute :organization

  def organization_id
    organization&.id
  end
end
