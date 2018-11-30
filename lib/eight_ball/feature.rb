# frozen_string_literal: true

module EightBall
  class Feature
    attr_accessor :name, :enabledFor, :disabledFor
    
    def initialize(name, enabledFor = [], disabledFor = [])
      @name = name
      @enabledFor = Array(enabledFor)
      @disabledFor = Array(disabledFor)
    end

    def enabled?(options = {})
      return true if @enabledFor.empty? && @disabledFor.empty?
      return true if @enabledFor.empty? && !any_satisfied?(@disabledFor, options)

      any_satisfied?(@enabledFor, options) && !any_satisfied?(@disabledFor, options)
    end

    private

    def any_satisfied?(conditions, options)
      conditions.any? do |condition|
        return condition.satisfied? if condition.parameter.nil?

        value = options[condition.parameter.to_sym]
        raise Exception, "Missing parameter #{condition.parameter}" if value.nil?

        condition.satisfied? value
      end
    end
  end
end
