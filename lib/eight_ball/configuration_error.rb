# frozen_string_literal: true

module EightBall
  class ConfigurationError < StandardError
    def initialize(msg = 'An invalid configuration was detected')
      super
    end
  end
end
