# app/policies/management_user_policy.rb

class ClientAccessPolicy < ApplicationPolicy
  def access?
    user.client?  # Check if the user is an admin
  end
end
