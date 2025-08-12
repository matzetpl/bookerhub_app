require 'rails_helper'

RSpec.describe CategorySyncService do
  let(:file_path) { 'config/categories.yml' }

  describe '#sync_categories' do
    context 'when YAML structure is correct' do
      it 'syncs categories from YAML file' do
        # Load the actual content of the categories.yml file
        categories_yaml = File.read(file_path)

        allow(YAML).to receive(:load_file).with(file_path).and_return(YAML.safe_load(categories_yaml))

        # Before syncing, count the existing categories
        initial_categories_count = Category.count

        service = CategorySyncService.new(file_path)
        service.sync_categories

        # After syncing, count the categories again
        final_categories_count = Category.count

        # Check that the number of categories remains the same after syncing
        expect(final_categories_count).to eq(initial_categories_count + YAML.safe_load(categories_yaml)['categories'].size)
        
        # Check that the newly added categories exist in the database
        YAML.safe_load(categories_yaml)['categories'].each do |category_attrs|
          # Construct the full path for the category slug including parent slugs
          parent_slug = category_attrs['parent_slug']
          full_slug = parent_slug.present? && parent_slug != 'nil' ? "#{parent_slug}/#{category_attrs['slug']}" : category_attrs['slug']
          
          category = Category.find_by(slug: "#{full_slug}")
   
          expect(category).to be_present
          expect(category.name).to eq(category_attrs['name'])
          
          # Adjusted expectation for nil parent slug
          expected_parent_slug = parent_slug == 'nil' ? nil : parent_slug
          expect(category.parent&.slug).to eq(expected_parent_slug)
        end
      end
    end

    context 'when YAML structure is incorrect' do
      it 'raises an error' do
        # Simulate incorrect YAML structure
        categories_yaml = <<~YAML
          invalid_structure:
            - name: Muzyka
              slug: muzyka
              parent_slug: nil

            - name: Rock
              slug: rock
              parent_slug: muzyka

            - name: Pop
              slug: pop
              parent_slug: muzyka
        YAML

        allow(YAML).to receive(:load_file).with(file_path).and_return(YAML.safe_load(categories_yaml))

        service = CategorySyncService.new(file_path)

        # Expect an error
        expect { service.sync_categories }.to raise_error(StandardError)
      end
    end

    context 'when running with real data from config' do
      it 'syncs and checks database content with YAML' do
        # Load the actual content of the categories.yml file
        categories_yaml = File.read(file_path)

        allow(YAML).to receive(:load_file).with(file_path).and_return(YAML.safe_load(categories_yaml))

        service = CategorySyncService.new(file_path)
        service.sync_categories

        # Read the categories from the YAML directly
        categories_from_yaml = YAML.safe_load(categories_yaml)['categories']

        # Check that each category from YAML is present in the database
        categories_from_yaml.each do |category_attrs|
          # Construct the full path for the category slug including parent slugs
          parent_slug = category_attrs['parent_slug']
          full_slug = parent_slug.present? && parent_slug != 'nil' ? "#{parent_slug}/#{category_attrs['slug']}" : category_attrs['slug']
          
          category = Category.find_by(slug: full_slug)
          expect(category).to be_present
          expect(category.name).to eq(category_attrs['name'])
          
          # Adjusted expectation for nil parent slug
          expected_parent_slug = parent_slug == 'nil' ? nil : parent_slug
          expect(category.parent&.slug).to eq(expected_parent_slug)
        end
      end
    end
  end
end
