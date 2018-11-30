# frozen_string_literal: true

module EightBall
  class Feature
    attr_accessor :name, :enabled_for, :disabled_for
    
    def initialize(name, enabled_for = [], disabled_for = [])
      @name = name
      @enabled_for = Array enabled_for
      @disabled_for = Array disabled_for
    end

    def enabled?(options = {})
      return true if @enabled_for.empty? && @disabled_for.empty?
      return true if @enabled_for.empty? && !any_satisfied?(@disabled_for, options)

      any_satisfied?(@enabled_for, options) && !any_satisfied?(@disabled_for, options)
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
