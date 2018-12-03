# frozen_string_literal: true

require 'date'

module EightBall::Providers::RefreshPolicies
  class Interval
    SECONDS_IN_A_DAY = 86_400
    
    def initialize(seconds = 60)
      @interval = seconds
      @fresh_until = nil
    end

    def refresh
      return unless block_given? && stale?

      yield
      @fresh_until = DateTime.now + Rational(@interval, SECONDS_IN_A_DAY)
    end

    protected

    def stale?
      @fresh_until.nil? || DateTime.now > @fresh_until
    end
  end
end
