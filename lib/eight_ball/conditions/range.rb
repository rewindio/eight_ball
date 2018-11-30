# frozen_string_literal: true

module EightBall::Conditions
  class Range < Base
    attr_accessor :min, :max
    
    def initialize(options = {})
      options ||= {}

      raise ArgumentError, 'Missing value for min' if options[:min].nil?
      raise ArgumentError, 'Missing value for max' if options[:max].nil?

      @min = options[:min]

      raise ArgumentError, 'Max must be greater or equal to min' if options[:max] < min

      @max = options[:max]

      self.parameter = options[:parameter]
    end

    def satisfied?(value)
      value >= min && value <= max
    end
  end
end
