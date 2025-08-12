module Management
  class MessagesController < Management::BaseController
    before_action :set_breadcrumbs_dashboard

    def index
      add_breadcrumb management_messages_url, 'Messages'
    end

    private

    def set_layout_heading
      @layout_data[:heading] = 'Messages'
    end
  end
end
 