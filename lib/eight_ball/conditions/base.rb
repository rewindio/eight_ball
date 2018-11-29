# frozen_string_literal: true

module EightBall::Conditions
  class Base
    attr_accessor :parameter

    def initialize(options = [])
      @parameter = nil
    end

    def satisfied?
      raise Exception.new 'You can never satisfy the Base condition'
    end
  end
end
