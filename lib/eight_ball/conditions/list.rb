# frozen_string_literal: true

module EightBall::Conditions
  class List < Base
    attr_accessor :values

    def initialize(options = {})
      options ||= {}

      @values = Array(options[:values])
      self.parameter = options[:parameter]
    end

    def satisfied?(value)
      values.include? value
    end
  end
end
