require 'faker'
require 'open-uri'

unless Admin.any?
  # Create an admin user
  admin = Admin.create!(
    email: "admin@admin.com",
    password: "111111",
    password_confirmation: "111111"
  )

  # Create an organization and associate it with the admin
  org = Organization.create!(name: 'Organization 1', admin_id: admin.id)
end

Category.delete_all

unless Category.any?
  synchronizer = CategorySyncService.new(Rails.root.join('config', 'categories.yml'))
  synchronizer.sync_categories
end

Event.delete_all
Event.destroy_all

sentence = Faker::Lorem.paragraph(sentence_count: 120)

# Wrap the paragraph in HTML tags
html_content = "<p>#{sentence}</p>"

# Example of adding multiple paragraphs
html_content = 5.times.map { "<p>#{Faker::Lorem.paragraph(sentence_count: 20)}</p>" }.join

# Example with headings, lists, etc.
html_content = <<-HTML
  <h3>Generated Heading</h3>
  <p>#{Faker::Lorem.paragraph(sentence_count: 5)}</p>
  <h3>Subheading</h3>
  <ul>
    #{5.times.map { "<li>#{Faker::Lorem.sentence}</li>" }.join}
  </ul>
  <p>#{Faker::Lorem.paragraph(sentence_count: 10)}</p>
HTML

image_url = "https://picsum.photos/500/700" # Random image from Lorem Picsum

# Iterate over each category
Category.find_each do |category|
  puts "CAT: #{category.name}"

  # Create 25 events for each category
  3.times do
    puts "times each"

    # Create an event for the category
    event = Event.new(
      category_id: category.id,
      name: Faker::Music.band, # Random event name
      description: html_content, # Random description
      image: nil, # ActiveStorage image placeholder
      status: "active", # Default status
      organization_id: Organization.first.id
    )

    event.save!

    # Attach a random image (requires ActiveStorage setup)
    begin
      io = URI.open(image_url)
      event.image.attach(
        io: io,
        filename: "event_placeholder_#{event.id}.jpg",
        content_type: "image/jpeg"
      )
    rescue OpenURI::HTTPError, Errno::ETIMEDOUT, Net::OpenTimeout, SocketError => e
      Rails.logger.warn "Image download failed for Event##{event.id} (#{image_url}): #{e.class} #{e.message} – attaching placeholder"
      placeholder_path = Rails.root.join("app/assets/images/placeholder.png")
      if File.exist?(placeholder_path)
        event.image.attach(
          io: File.open(placeholder_path),
          filename: "placeholder.png",
          content_type: "image/jpeg"
        )
      end
    end

    # Generate random locations with ordered dates
    location_count = rand(1..5) # Random number of locations per event
    current_date = Faker::Date.between(from: Date.today, to: 1.year.from_now)
    puts "LOCATION COUNT: #{location_count}"

    location_count.times do
      puts "location each"

      # Create an event location
      event_location = EventLocation.create!(
        event_id: event.id,
        name: Faker::Address.community, # Random location name
        city: Faker::Address.city,      # Random city name
        street: Faker::Address.street_name,
        house: Faker::Address.building_number,
        apartment: Faker::Address.secondary_address,
        post_code: Faker::Address.zip_code,
        lng: Faker::Address.longitude,
        lat: Faker::Address.latitude,
      )

      # Create 2 ticket pools for each location with "STANDARD" and "VIP" types
      ticket_types = TicketPool.ticket_types.keys
      ticket_types.each_with_index do |ticket_type, i|
        ticket_pool = TicketPool.create!(
          event_location_id: event_location.id,
          name: "#{ticket_type}", # Unique name for the pool
          ticket_type: ticket_type, # Set ticket type as "STANDARD" or "VIP"
          capacity: rand(100..500), # Random capacity for the ticket pool
          valid_from: Date.today, # Validity start date
          valid_until: current_date + rand(1..30).days, # Validity end date
          ticket_date_from: current_date + rand(1..5).days, # Ticket sale start date
          ticket_date_to: current_date + rand(6..10).days # Ticket sale end date
        )

        # Optionally, adjust the date to ensure it's sequential
        current_date += rand(1..30).days
      end
    end
  end
end

puts "Seed data created successfully!"
