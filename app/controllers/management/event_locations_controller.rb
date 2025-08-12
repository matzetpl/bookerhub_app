module Management
  class EventLocationsController < Management::BaseController
    before_action :set_breadcrumbs_dashboard
    before_action :set_event
    before_action :set_event_location, only: [ :show, :destroy, :show, :edit, :update ]



    def show
      add_breadcrumb management_events_url, "Events"
      add_breadcrumb management_event_url(@event), "(#{@event.id} - #{@event.name})"
      add_breadcrumb nil, "Event Locations"
      add_breadcrumb nil, "(#{@event_location.id} - #{@event_location.name})"

      respond_to do |format|
        format.html
      end
      # Logic for showing a single event
    end

    def new
      @event_location = EventLocation.new(event: @event)
      render turbo_stream: turbo_stream.replace("resourceModalContent", partial: "management/event_locations/form")

      # Logic for creating a new event (form)
    end

    def create
      @event_location = EventLocation.new(event_location_params)
      @event_location.event_id = @event.id


      if !@event_location.save
        raise @event_location.errors.inspect
      end


      render turbo_stream: [
        turbo_stream.replace("eventShowEventLocations", partial: "management/events/events_locations"),
        turbo_stream_close_modal_form,
        render_stream_notice
      ]
      # Logic for saving a new event
    end

    def edit
      authorize [ :management, @event ]
      render turbo_stream: turbo_stream.replace("resourceModalContent", partial: "management/event_locations/form")
    end

    def update
      authorize [ :management, @event ]

      @event_location.update(event_location_params)
      # render turbo_stream: turbo_stream.replace("resourceModalContent", partial: "management/events/form", locals: { event: @event })
      render turbo_stream: [
        turbo_stream.replace("eventShowEventLocations", partial: "management/events/events_locations"),
        turbo_stream.replace("heading_event_location_#{@event_location.id}", partial: "management/event_locations/event_location_heading"),
        turbo_stream_close_modal_form,
        render_stream_notice
      ]
    end


    def destroy
      @event_location.destroy
      render turbo_stream: [
        turbo_stream.replace("eventShowEventLocations", partial: "management/events/events_locations"),
        render_stream_notice
      ]
      # Logic for deleting an event
    end

    private


    def set_layout_heading
      @layout_data[:heading] = "Event - Lokalizacja"
    end

    def set_event_location
      @event_location = @event.event_locations.find(params[:id])
    end

    def set_event
      @event = Event.all.by_organization.find_by(id: params[:event_id])
    end

    def event_location_params
      params.require(:event_location).permit(:name, :lng, :lat, :address, :post_code, :city, :street, :house, :apartment)
    end
  end
end
