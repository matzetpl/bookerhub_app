class CreateEventLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :event_locations do |t|
      t.string :name
      t.integer :event_id
      t.timestamps
    end
  end
end
