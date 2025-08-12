module Management
  class DashboardController < Management::BaseController
    def index
      flash[:notice] = "TEST"

      # Logic for listing events
    end

    private

    def set_layout_heading
      @layout_data[:heading] = "Dashboard"
    end
  end
end
