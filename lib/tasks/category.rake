namespace :category do
  desc "Sync categories from categories.yml"
  task sync_categories: :environment do
    synchronizer = CategorySyncService.new(Rails.root.join('config', 'categories.yml'))
    synchronizer.sync_categories
    puts "Categories synchronized successfully!"
  end
end