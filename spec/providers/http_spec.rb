# frozen_string_literal: true

RSpec.describe EightBall::Providers::Http do
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
      expect { EightBall::Providers::Http.new 'bogus' }.to raise_error ArgumentError, 'Invalid HTTP/HTTPS URI provided'
    end
  end

  describe 'features' do
    it 'should fetch data' do
      policy_double = double
      allow(policy_double).to receive(:refresh).and_yield

      expect(Net::HTTP).to receive(:get).with(URI.parse(@uri))

      provider = EightBall::Providers::Http.new @uri, refresh_policy: policy_double
      provider.features
    end

    it 'should use provided parser to parse response' do
      allow(Net::HTTP).to receive(:get).and_return @file

      parser_double = double
      expect(parser_double).to receive(:parse).and_return ['features']

      expect(EightBall::Providers::Http.new(@uri, parser: parser_double).features).to contain_exactly 'features'
    end

    it 'should use provided policy to refresh data' do
      allow(Net::HTTP).to receive(:get).and_return @file

      policy_double = double
      expect(policy_double).to receive(:refresh).and_yield

      EightBall::Providers::Http.new(@uri, refresh_policy: policy_double).features
    end
  end

  describe 'fetch' do
    it 'should default to [] if error occurs' do
      expect(Net::HTTP).to receive(:get).and_raise StandardError

      expect(EightBall::Providers::Http.new(@uri).features).to eq []
    end
  end
end
