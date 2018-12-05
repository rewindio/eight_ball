# frozen_string_literal: true

require 'plissken'

module EightBall::Parsers
  # A JSON parser will parse JSON into a list of {EightBall::Feature Features}.
  # The top-level JSON element must be an array and must use camel-case;
  # this will be converted to snake-case by EightBall.
  #
  # Below are some examples of valid JSON:
  #
  # @example A single {EightBall::Feature} is enabled for accounts 1-5 as well as region Europe
  #   [{
  #     "name": "Feature1",
  #     "enabledFor": [{
  #       "type": "range",
  #       "parameter": "accountId",
  #       "min": 1,
  #       "max": 5
  #     }, {
  #       "type": "list",
  #       "parameter": "regionName",
  #       "values": ["Europe"]
  #     }]
  #   }]
  #
  # @example A single {EightBall::Feature} is disabled completely using the {EightBall::Conditions::Always Always} condition
  #   [{
  #     "name": "Feature1",
  #     "disabledFor": [{
  #       "type": "always"
  #     }]
  #   }]
  class Json
    # Convert the JSON into a list of {EightBall::Feature Features}.
    #
    # @param [String] json The JSON string to parse.
    # @return [Array<EightBall::Feature>] The parsed {EightBall::Feature Features}
    #
    # @example
    #   json_string = <Read from somewhere>
    #
    #   parser = EightBall::Parsers::Json.new
    #   parser.parse json_string => [Features]
    def parse(json)
      parsed = JSON.parse(json, :symbolize_names => true).to_snake_keys
      
      raise ArgumentError, 'JSON input was not an array' unless parsed.is_a? Array

      parsed.map do |feature|
        enabled_for = create_conditions feature[:enabled_for]
        disabled_for = create_conditions feature[:disabled_for]

        EightBall::Feature.new feature[:name], enabled_for, disabled_for
      end
    rescue JSON::ParserError => e
      EightBall.logger.error { "Failed to parse JSON: #{e.message}" }
      []
    end

    private

    def create_conditions(json_conditions)
      return [] unless json_conditions && json_conditions.is_a?(Array)

      json_conditions.map do |condition|
        condition_class = EightBall::Conditions.by_name condition[:type]
        condition_class.new condition
      end
    end
  end
end
