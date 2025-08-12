module Elasticable
  extend ActiveSupport::Concern


  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    class_attribute :searchable_options

    after_commit lambda { __elasticsearch__.index_document }, on: [:create, :update]
    after_commit lambda { __elasticsearch__.delete_document }, on: :destroy



    def as_indexed_json(_options = {})
    {
      name: name,
      # Add more fields as needed
    }
    end 


  end

  class_methods do
    def searchable_fields(*fields)
      self.searchable_options ||= {}
      self.searchable_options[:fields] = fields
    end

    def searchable_fuzziness(fuzziness)
      self.searchable_options ||= {}
      self.searchable_options[:fuzziness] = fuzziness
    end
  end
end