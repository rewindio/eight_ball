# frozen_string_literal: true

module EightBall::Conditions
  class Base
    attr_reader :parameter

    def initialize(_options = [])
      @parameter = nil
    end

    def satisfied?
      raise 'You can never satisfy the Base condition'
    end

    protected

    def parameter=(parameter)
      return if parameter.nil?

      @parameter = parameter.gsub(/(.)([A-Z])/, '\1_\2').downcase
    end
  end
end
