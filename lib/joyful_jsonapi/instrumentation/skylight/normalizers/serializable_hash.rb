require 'joyful_jsonapi/instrumentation/skylight/normalizers/base'
require 'joyful_jsonapi/instrumentation/serializable_hash'

module JoyfulJsonapi
  module Instrumentation
    module Skylight
      module Normalizers
        class SerializableHash < SKYLIGHT_NORMALIZER_BASE_CLASS

          register JoyfulJsonapi::ObjectSerializer::SERIALIZABLE_HASH_NOTIFICATION

          CAT = "view.#{JoyfulJsonapi::ObjectSerializer::SERIALIZABLE_HASH_NOTIFICATION}".freeze

          def normalize(trace, name, payload)
            [ CAT, payload[:name], nil ]
          end

        end
      end
    end
  end
end
