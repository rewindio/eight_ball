# frozen_string_literal: true

require 'test_helper'

describe EightBall::Parsers::Json do
  describe 'parse' do
    before do
      @parser = EightBall::Parsers::Json.new
    end

    it 'should raise error if provided JSON not an array' do
      json = %(
        {
          "name": "NoConditions"
        }
      )

      e = -> { @parser.parse(json) }.must_raise Exception
      e.message.must_equal 'JSON input was not an array'
    end

    it 'should convert JSON into an array of Features' do
      json = %(
        [{
          "name": "NoConditions"
        }, {
          "name": "WithConditions",
          "enabledFor": [{
            "type": "list",
            "parameter": "param1",
            "values": [1, 2, 3, 4]
          }],
          "disabledFor": [{
            "type": "never"
          }]
        }]
      )

      features = @parser.parse json

      features.size.must_equal 2

      features[0].name.must_equal 'NoConditions'
      features[0].enabledFor.size.must_equal 0
      features[0].disabledFor.size.must_equal 0

      features[1].name.must_equal 'WithConditions'
      features[1].enabledFor.size.must_equal 1
      features[1].enabledFor[0].is_a? EightBall::Conditions::List
      features[1].enabledFor[0].parameter.must_equal 'param1'
      features[1].enabledFor[0].values.must_equal [1, 2, 3, 4]
      features[1].disabledFor.size.must_equal 1
      features[1].disabledFor[0].is_a? EightBall::Conditions::Never
    end
  end
end
