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

    def ==(other)
      other.class == self.class && other.state == state
    end
    alias eql? ==

    def hash
      state.hash
    end

    protected

    def state
      [@parameter]
    end

    def parameter=(parameter)
      return if parameter.nil?

      @parameter = parameter.gsub(/(.)([A-Z])/, '\1_\2').downcase
    end
  end
end
