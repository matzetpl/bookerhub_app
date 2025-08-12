class CreateTicketPools < ActiveRecord::Migration[8.0]
  def change
    create_table :ticket_pools do |t|
      t.string :name, null: false # np. "VIP - Dzień 1", "Karnet 3-dniowy"
      t.string :ticket_type, default: 0, null: false  # Set default value for status

      t.integer :capacity, null: false
      t.datetime :valid_from, null: false # Od kiedy można kupować bilety
      t.datetime :valid_until, null: false # Do kiedy można kupować bilety

      t.datetime :ticket_date_from, null: false # Do kiedy można kupować bilety
      t.datetime :ticket_date_to, null: false # Do kiedy można kupować bilety

      t.references :event_location, foreign_key: true, null: false
      t.timestamps
    end
  end
end
