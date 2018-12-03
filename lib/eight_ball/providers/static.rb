# frozen_string_literal: true

module EightBall::Providers
  class Static
    attr_reader :features

    def initialize(features = [])
      @features = features
    end
  end
end
