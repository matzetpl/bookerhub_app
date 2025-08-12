class HomeController < BaseController
  def index
    add_breadcrumb "#", "Home"

    @events_newest = Event.all.by_active.limit(6)

    @events_av = Event.with_valid_ticket_pool_near_today
    @events_av = @events_av.by_active.limit(6)
  end

  def stimulus_test
    # raise 'stimulus test'.inspect
  end
end
