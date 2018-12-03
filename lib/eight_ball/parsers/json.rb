# frozen_string_literal: true

require 'plissken'

module EightBall::Parsers
  class Json
    def parse(raw)
      parsed = JSON.parse(raw, :symbolize_names => true).to_snake_keys

      raise ArgumentError, 'JSON input was not an array' unless parsed.is_a? Array

      parsed.map do |feature|
        enabled_for = create_conditions feature[:enabled_for]
        disabled_for = create_conditions feature[:disabled_for]

        EightBall::Feature.new feature[:name], enabled_for, disabled_for
      end
    end

    private

    def create_conditions(raw_conditions)
      return [] unless raw_conditions && raw_conditions.is_a?(Array)

      raw_conditions.map do |condition|
        condition_class = EightBall::Conditions.by_name condition[:type]
        condition_class.new condition
      end
    end
  end
end
