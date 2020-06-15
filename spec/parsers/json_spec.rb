# frozen_string_literal: true

RSpec.describe EightBall::Parsers::Json do
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

      expect{ @parser.parse(json) }.to raise_error ArgumentError, 'JSON input was not an array'
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

      expect(features.size).to be 2

      expect(features[0].name).to eq 'NoConditions'
      expect(features[0].enabled_for.size).to be 0
      expect(features[0].disabled_for.size).to be 0

      expect(features[1].name).to eq 'WithConditions'
      expect(features[1].enabled_for.size).to be 1
      expect(features[1].enabled_for[0]).to be_a EightBall::Conditions::List
      expect(features[1].enabled_for[0].parameter).to eq 'param1'
      expect(features[1].enabled_for[0].values).to contain_exactly 1, 2, 3, 4
      expect(features[1].disabled_for.size).to be 1
      expect(features[1].disabled_for[0]).to be_a EightBall::Conditions::Never
    end

    it 'should default to [] if parsing error occurs' do
      allow(JSON).to receive(:parse).and_raise JSON::ParserError

      features = @parser.parse ''

      expect(features).to eq []
    end
  end
end
