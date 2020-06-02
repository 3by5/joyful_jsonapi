require 'action_controller/metal/strong_parameters'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/string/inflections'

module JoyfulJsonapi
  class Parameters
    def initialize(original_params)
      @jsonapi_params = original_params.to_unsafe_h.with_indifferent_access
      @rails_params = {_jsonapi_document: @jsonapi_params}.with_indifferent_access
    end

    def to_action_controller_params
      populate_root_key
      extract_attributes
      extract_relationships
      finalize
    end

    private

    def populate_root_key
      rails_attribute_hash
    end

    def extract_attributes
      @jsonapi_params[:data][:attributes].each do |k,v|
        rails_attribute_hash[k.underscore] = v
      end
    end

    def extract_relationships
      relationship_params = @jsonapi_params[:data][:relationships].dup
      rails_relationship_hash = {}
      (relationship_params || {}).each do |name, jsonapi_relationship_object|
        rails_relationship_hash["#{name.underscore}_id"] = jsonapi_relationship_object[:data][:id]
      end
      rails_attribute_hash.merge!(rails_relationship_hash)
    end

    def rails_attribute_hash
      @rails_params[type_key] ||= {} 
    end

    def type_key
      @type_key ||= @jsonapi_params[:data][:type].singularize.underscore
    end

    def finalize
      ActionController::Parameters.new(@rails_params)
    end
  end
end