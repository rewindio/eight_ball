# frozen_string_literal: true

require 'test_helper'

describe EightBall::Providers::Http do
  before do
    @uri = 'http://www.rewind.io'
    @file = %(
      [{
        "name": "Feature1",
        "enabledFor": [{
          "type": "range",
          "parameter": "accountId",
          "min": 1,
          "max": 10
        }],
        "disabledFor": [{
          "type": "list",
          "parameter": "accountId",
          "values": [2, 3]
        }]
      }]
    )
  end

  describe 'initialize' do
    it 'should raise Exception if given invalid URI' do
      e = -> { EightBall::Providers::Http.new 'bogus' }.must_raise Exception
      e.message.must_equal 'Invalid HTTP/HTTPS URI provided'
    end
  end

  describe 'features' do
    it 'should fetch data if it hasn\'t yet' do
      Net::HTTP.stubs(:get).once.with { |value| value.to_s == @uri }.returns @file

      EightBall::Providers::Http.new(@uri).features
    end

    it 'should use provided parser to parse response' do
      Net::HTTP.stubs(:get).returns @file

      stub_parser = stub
      stub_parser.stubs(:parse).once.returns ['features']

      EightBall::Providers::Http.new(@uri, parser: stub_parser).features.must_equal ['features']
    end
  end
end
