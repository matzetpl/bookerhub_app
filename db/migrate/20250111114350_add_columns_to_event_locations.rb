class AddColumnsToEventLocations < ActiveRecord::Migration[8.0]
  def change
    add_column :event_locations, :date, :datetime
    add_column :event_locations, :lng, :string
    add_column :event_locations, :lat, :string
    add_column :event_locations, :address, :string
    add_column :event_locations, :post_code, :string
    add_column :event_locations, :city, :string
    add_column :event_locations, :street, :string
    add_column :event_locations, :house, :string
    add_column :event_locations, :apartment, :string
  end
end
