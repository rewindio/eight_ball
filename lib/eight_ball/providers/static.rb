# frozen_string_literal: true

module EightBall::Providers
  # A Static provider will always provide the exact list of {EightBall::Features}
  # that were passed in at construction time.
  class Static
    attr_reader :features

    # Creates a new instance of a Static Provider.
    #
    # @param features [Array<EightBall::Feature>, EightBall::Feature]
    #   The {EightBall::Feature Feature(s)} that this provider will return.
    #
    # @example
    #   provider = EightBall::Providers::Static.new([
    #     EightBall::Feature.new 'feature1',
    #     EightBall::Feature.new 'feature2'
    #   ])
    def initialize(features = [])
      @features = Array features
    end
  end
end
