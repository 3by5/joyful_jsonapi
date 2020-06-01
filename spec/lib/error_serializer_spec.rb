require 'spec_helper'

class TestModel
  include ActiveModel::Model
  attr_accessor :foo, :bar, :baz
  
  validates :foo, presence: true
  validates :bar, numericality: true
end

RSpec.describe JoyfulJsonapi::ErrorSerializer do
  let(:model) { TestModel }

  describe '#serializable_hash' do
    let(:model_instance) { model.new(foo: nil, bar: 'One') }
    it 'returns a jsonapi complliant error array' do
      expect(JoyfulJsonapi::ErrorSerializer.new(model_instance).serializable_hash).to eq({
      errors: [
        {
          status: "422",
          detail: 'can\'t be blank',
          source: {
            pointer: '/data/attributes/foo'
          }
        },
        {
          status: "422",
          detail: 'is not a number',
          source: {
            pointer: '/data/attributes/bar'
          }
        }
      ]
    })
    end
  end
end