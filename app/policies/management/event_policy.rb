module Management
  class EventPolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        scope.joins(:organization).where(organizations: { admin_id: user.id })
      end
    end

    def update?
      edit?
    end

    def edit?
      common_can? && record.organization_id == CurrentOrganization.organization.id
    end

    def index?
      common_can?
    end

    private

    def common_can?
      user.admin? && user.organization.present? && (check_is_current_organization_for_admin)
    end
  end
end
