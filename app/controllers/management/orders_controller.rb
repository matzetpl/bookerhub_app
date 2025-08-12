module Management
  class OrdersController < Management::BaseController
    before_action :set_breadcrumbs_dashboard

    def index
      add_breadcrumb management_events_url, 'Orders'
    end

    private

    def set_layout_heading
      @layout_data[:heading] = 'Orders'
    end
  end
end
