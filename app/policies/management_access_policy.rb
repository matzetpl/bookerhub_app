# app/policies/management_user_policy.rb

class ManagementAccessPolicy < ApplicationPolicy
  def access?
    user.admin?  # Check if the user is an admin
  end
end
