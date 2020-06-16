# frozen_string_literal: true

RSpec.describe EightBall::Marshallers::Json do
  let(:marshaller) { EightBall::Marshallers::Json.new }

  describe 'marshall' do
    it 'should convert an array of Features into pretty-printed JSON' do
      features = [
        EightBall::Feature.new(
          'WithConditions',
          [EightBall::Conditions::List.new(values: [1, 2, 3, 4], parameter: 'param1')],
          [EightBall::Conditions::Never.new]
        )
      ]

      json = <<~JSON.chomp
        [
          {
            "name": "WithConditions",
            "enabledFor": [
              {
                "type": "list",
                "values": [
                  1,
                  2,
                  3,
                  4
                ],
                "parameter": "param1"
              }
            ],
            "disabledFor": [
              {
                "type": "never"
              }
            ]
          }
        ]
      JSON

      expect(marshaller.marshall(features)).to eq json
    end

    it 'should not include disabledFor key if empty' do
      features = [EightBall::Feature.new('WithConditions', [EightBall::Conditions::Always.new])]

      json = <<~JSON.chomp
        [
          {
            "name": "WithConditions",
            "enabledFor": [
              {
                "type": "always"
              }
            ]
          }
        ]
      JSON

      expect(marshaller.marshall(features)).to eq json
    end

    it 'should not include enabledFor key if empty' do
      features = [EightBall::Feature.new('WithConditions', nil, [EightBall::Conditions::Always.new])]

      json = <<~JSON.chomp
        [
          {
            "name": "WithConditions",
            "disabledFor": [
              {
                "type": "always"
              }
            ]
          }
        ]
      JSON

      expect(marshaller.marshall(features)).to eq json
    end

    it 'should not include "parameter" and "value" keys if not present' do
      features = [
        EightBall::Feature.new(
          'WithConditions',
          [EightBall::Conditions::Always.new],
          [EightBall::Conditions::Never.new]
        )
      ]

      json = <<~JSON.chomp
        [
          {
            "name": "WithConditions",
            "enabledFor": [
              {
                "type": "always"
              }
            ],
            "disabledFor": [
              {
                "type": "never"
              }
            ]
          }
        ]
      JSON

      expect(marshaller.marshall(features)).to eq json
    end
  end

  describe 'unmarshall' do
    it 'should raise error if provided JSON is not an array' do
      json = %(
        {
          "name": "NoConditions"
        }
      )

      expect { marshaller.unmarshall(json) }.to raise_error ArgumentError, 'JSON input was not an array'
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

      features = marshaller.unmarshall json

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

    it 'should default to [] if JSON parsing error occurs' do
      allow(JSON).to receive(:parse).and_raise JSON::ParserError

      features = marshaller.unmarshall ''

      expect(features).to eq []
    end
  end
end
