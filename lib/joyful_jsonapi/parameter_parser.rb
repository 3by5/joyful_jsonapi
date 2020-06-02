module JoyfulJsonapi
  module ParameterParser
    extend ActiveSupport::Concern

    class_methods do
      def translate_jsonapi_params(options)
        before_actions options do
          @_params = JoyfulJsonapi::Parameters.new(params)
                                              .to_action_controller_params
        end
      end
    end
  end
end