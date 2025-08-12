class SearchController < BaseController
  def index
    search_query = URI.encode_www_form_component(params[:q])
    add_breadcrumb "#", "Wyniki wyszukiwania dla: #{search_query}"

    collection = Event.pagy_search(search_query)

    @pagy, @events = pagy_elasticsearch_rails(collection, limit: 10)

    events_objects_ids = @events.map { |e| e.id }
    @events_objects = Event.where(id: events_objects_ids)
  end
end
