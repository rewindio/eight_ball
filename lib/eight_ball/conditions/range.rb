# frozen_string_literal: true

module EightBall::Conditions
  class Range < Base
    attr_accessor :min, :max
    
    def initialize(options = {})
      options ||= {}

      raise Exception, 'Missing value for min' if options[:min].nil?
      raise Exception, 'Missing value for max' if options[:max].nil?

      @min = options[:min]
      @max = options[:max] > min ? options[:max] : min

      self.parameter = options[:parameter]
    end

    def satisfied?(value)
      value >= min && value <= max
    end
  end
end
