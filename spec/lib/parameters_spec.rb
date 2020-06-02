require 'spec_helper'

describe JoyfulJsonapi::Parameters do
  let(:jsonapi_params) do
    ActionController::Parameters.new({
      data: {
        type: 'some-class',
        attributes: {
          string_attribute: 'lalalala',
          number_attribute: 1,
          boolean_attribute: false
        },
        relationships: {
          'other-class': {
            data: {
              type: 'other-class',
              id: 1
            }
          }
        }
      }
    })
  end

  describe '#to_action_controller_params' do
    it 'converts the original parameters hash into a more conventional rails one' do
      expect(
        JoyfulJsonapi::Parameters.new(jsonapi_params).to_action_controller_params
      .to_unsafe_h.deep_symbolize_keys).to include({
        some_class: {
          string_attribute: 'lalalala',
          number_attribute: 1,
          boolean_attribute: false,
          other_class_id: 1
        }
      })
    end
  end
end