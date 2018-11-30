# frozen_string_literal: true

module EightBall::Parsers
  class Json
    def parse(raw)
      parsed = JSON.parse raw, :symbolize_names => true

      raise ArgumentError, 'JSON input was not an array' unless parsed.is_a? Array

      parsed.map do |feature|
        enabledFor = create_conditions feature[:enabledFor]
        disabledFor = create_conditions feature[:disabledFor]

        EightBall::Feature.new feature[:name], enabledFor, disabledFor
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
