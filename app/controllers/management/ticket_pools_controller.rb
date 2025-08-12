module Management
  class TicketPoolsController < Management::BaseController
    before_action :set_breadcrumbs_dashboard
    before_action :set_event
    before_action :set_event_location
    before_action :set_ticket_pool, only: [ :edit, :update, :destroy ]

    def new
      @ticket_pool = TicketPool.new(event_location: @event_location)
      render turbo_stream: turbo_stream.replace("resourceModalContent", partial: "management/ticket_pools/form")
      # Logic for creating a new event (form)
    end

    def create
      @ticket_pool = TicketPool.new(ticket_pool_params)
      @ticket_pool.event_location_id = @event_location.id


      if !@ticket_pool.save
        raise @ticket_pool.errors.inspect
      end

      render turbo_stream: [
        turbo_stream.replace("eventLoctationShowTicketPools", partial: "management/event_locations/ticket_pools"),
        turbo_stream_close_modal_form,
        render_stream_notice
      ]
      # Logic for saving a new event
    end

    def edit
      authorize [ :management, @event ]
      render turbo_stream: turbo_stream.replace("resourceModalContent", partial: "management/ticket_pools/form")
    end

    def update
      authorize [ :management, @event ]

      @ticket_pool.update(ticket_pool_params)
      # render turbo_stream: turbo_stream.replace("resourceModalContent", partial: "management/events/form", locals: { event: @event })
      render turbo_stream: [
        turbo_stream.replace("eventLoctationShowTicketPools", partial: "management/event_locations/ticket_pools"),
        turbo_stream_close_modal_form,
        render_stream_notice
      ]
    end


    def destroy
      @ticket_pool.destroy
      render turbo_stream: [
        turbo_stream.replace("eventLoctationShowTicketPools", partial: "management/event_locations/ticket_pools"),
        render_stream_notice
      ]
      # Logic for deleting an event
    end

    private


    def set_event
      @event = Event.all.by_organization.find_by(id: params[:event_id])
    end

    def set_event_location
      @event_location = @event.event_locations.find(params[:event_location_id])
    end

    def set_ticket_pool
      @ticket_pool = @event_location.ticket_pools.find(params[:id])
    end

    def ticket_pool_params
      params.require(:ticket_pool).permit(:name, :ticket_type, :capacity, :valid_from, :valid_until, :ticket_date_from, :ticket_date_to)
    end
  end
end
