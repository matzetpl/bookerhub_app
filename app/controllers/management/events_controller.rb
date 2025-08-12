module Management
  class EventsController < Management::BaseController
    before_action :set_breadcrumbs_dashboard
    before_action :set_event, only: [ :destroy, :show, :edit, :update ]

    def index
      add_breadcrumb management_events_url, "Events"
      @events = Event.all.by_organization
      authorize [ :management, Event ]

      @pagy, @events = pagy(@events, items: 10)

      # Logic for listing events
    end

    def show
      add_breadcrumb management_events_url, "Events"
      add_breadcrumb nil, "Podgląd (#{@event.id} - #{@event.name})"

      respond_to do |format|
        format.html
      end
      # Logic for showing a single event
    end

    def new
      @event = Event.new(organization_id: CurrentOrganization.organization_id)
      # Logic for creating a new event (form)
    end

    def create
      # Logic for saving a new event
    end

    def test_update
      render turbo_stream: turbo_stream.replace("example_frame") do
        "<p>Updated content!</p>".html_safe
      end
    end

    def edit
      @event = Event.find(params[:id])
      authorize [ :management, @event ]

      add_breadcrumb management_events_url, "Events"
      add_breadcrumb nil, "Edycja (#{@event.id} - #{@event.name})"
      render turbo_stream: turbo_stream_render_modal_form("management/events/form")
    end

    def update
      authorize [ :management, @event ]

      (@event.update(event_params)) ? flash_message_success : flash_message_error

      render turbo_stream: [
        turbo_stream_update_main(template: "management/events/show"),
        turbo_stream_close_modal_form,
        render_stream_notice
      ]
    end


    def destroy
      # Logic for deleting an event
    end

    private





    def set_event
      @event = Event.all.by_organization.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:name, :image, :description, :status, :category_id)
    end

    def set_layout_heading
      @layout_data[:heading] = "Events"
    end
  end
end
