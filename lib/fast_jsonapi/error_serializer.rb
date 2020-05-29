
module FastJsonapi
  class ErrorSerializer

    def initialize(model)
      @model = model
      @model.valid?
    end

    def serializable_hash
      { errors: errors_for(@model) }
    end

    def serialized_json(options = nil)
      serializable_hash.to_json(options)
    end

    private

    def errors_for(resource)
      resource.errors.messages.flat_map do |field, errors|
        build_hashes_for(field, errors)
      end
    end

    def build_hashes_for(field, errors)
      errors.map do |error_message|
        build_hash_for(field, error_message)
      end.flatten
    end

    def build_hash_for(field, error_message)
      {}.tap do |hash|
        hash[:status] = "422"
        hash[:source] = { pointer: "/data/attributes/#{field}" }
        hash[:detail] = error_message
      end
    end

  end
end