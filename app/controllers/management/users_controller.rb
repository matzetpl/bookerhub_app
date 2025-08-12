module Management
  class UsersController < Management::BaseController
    before_action :set_breadcrumbs_dashboard

    def index
      add_breadcrumb management_users_url, 'Users'
    end

    private

    def set_layout_heading
      @layout_data[:heading] = 'Users'
    end
  end
end
 