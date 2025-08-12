module Management
  class ClientsController < Management::BaseController
    before_action :set_breadcrumbs_dashboard

    def index
      add_breadcrumb management_clients_url, 'Clients'
    end

    private

    def set_layout_heading
      @layout_data[:heading] = 'Clients'
    end
  end
end
 