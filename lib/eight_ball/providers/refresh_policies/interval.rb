# frozen_string_literal: true

require 'date'

module EightBall::Providers::RefreshPolicies
  # An Interval RefreshPolicy states that data is considered fresh for a certain
  # amount of time, after which it is considered stale and should be refreshed.
  class Interval
    SECONDS_IN_A_DAY = 86_400

    # Creates a new instance of an Interval RefreshPolicy.
    #
    # @param seconds [Integer] The number of seconds the data is considered fresh.
    #
    # @example New data stays fresh for 2 minutes
    #   EightBall::Providers::RefreshPolicies::Interval.new 120
    def initialize(seconds = 60)
      @interval = seconds
      @fresh_until = nil
    end

    # Yields if the current data is stale, in order to refresh it.
    # Resets the interval once the data is refreshed.
    #
    # @example Load new data if current data is stale
    #   policy.refresh { load_new_data }
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
