module Management
  class PaymentsController < Management::BaseController
    before_action :set_breadcrumbs_dashboard

    def index
      add_breadcrumb management_payments_url, 'Payments'
    end

    private

    def set_layout_heading
      @layout_data[:heading] = 'Payments'
    end
  end
end
 