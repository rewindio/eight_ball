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
      e = -> { EightBall::Providers::Http.new 'bogus' }.must_raise ArgumentError
      e.message.must_equal 'Invalid HTTP/HTTPS URI provided'
    end
  end

  describe 'features' do
    it 'should fetch data' do
      stub_policy = stub
      stub_policy.stubs(:refresh).once.yields

      Net::HTTP.stubs(:get).once.with { |value| value.to_s == @uri }.returns @file

      provider = EightBall::Providers::Http.new @uri, refresh_policy: stub_policy
      provider.features
    end

    it 'should use provided parser to parse response' do
      Net::HTTP.stubs(:get).returns @file

      stub_parser = stub
      stub_parser.stubs(:parse).once.returns ['features']

      EightBall::Providers::Http.new(@uri, parser: stub_parser).features.must_equal ['features']
    end

    it 'should use provided policy to refresh data' do
      Net::HTTP.stubs(:get).returns @file

      stub_parser = stub
      stub_parser.stubs(:parse).once.returns ['features']

      EightBall::Providers::Http.new(@uri, parser: stub_parser).features.must_equal ['features']
    end
  end

  describe 'fetch' do
    it 'should default to [] if error occurs' do
      Net::HTTP.stubs(:get).raises StandardError

      EightBall::Providers::Http.new(@uri).features.must_equal []
    end
  end
end
