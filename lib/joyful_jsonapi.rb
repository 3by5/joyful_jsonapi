# frozen_string_literal: true

module JoyfulJsonapi
  require 'joyful_jsonapi/object_serializer'
  require 'joyful_jsonapi/error_serializer'
  if defined?(::Rails)
    require 'joyful_jsonapi/railtie'
  elsif defined?(::ActiveRecord)
    require 'extensions/has_one'
  end
end
