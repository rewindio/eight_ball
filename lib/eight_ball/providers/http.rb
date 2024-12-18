# frozen_string_literal: true

require 'net/http'

module EightBall::Providers
  # An HTTP Provider will make a GET request to a given URI, and convert
  # the response into an array of {EightBall::Feature Features} using the
  # given {EightBall::Marshallers Marshaller}.
  #
  # The {EightBall::Feature Features} will be automatically kept up to date
  # according to the given {EightBall::Providers::RefreshPolicies RefreshPolicy}.
  class Http
    SUPPORTED_SCHEMES = %w[http https].freeze

    attr_reader :marshaller

    # @param uri [String] The URI to GET the {EightBall::Feature Features} from.
    # @param options [Hash] The options to create the Provider with.
    #
    # @option options [EightBall::Marshallers] :marshaller
    #   The {EightBall::Marshallers Marshaller} used to convert the response to an array
    #   of {EightBall::Feature Features}. Defaults to an instance of
    #   {EightBall::Marshallers::Json}
    #
    # @option options [EightBall::Providers::RefreshPolicies] :refresh_policy
    #   The {EightBall::Providers::RefreshPolicies Policy} used to determine
    #   when the {EightBall::Feature Features} have gone stale and need to be
    #   refreshed. Defaults to an instance of
    #   {EightBall::Providers::RefreshPolicies::Interval}
    #
    # @example
    #   provider = EightBall::Providers::Http.new(
    #     'http://www.rewind.io',
    #     refresh_policy: EightBall::Providers::RefreshPolicies::Interval.new 120
    #   )
    def initialize(uri, options = {})
      raise ArgumentError, 'Invalid HTTP/HTTPS URI provided' unless uri =~ URI.regexp(SUPPORTED_SCHEMES)

      @uri = URI.parse uri

      @marshaller = options[:marshaller] || EightBall::Marshallers::Json.new
      @policy = options[:refresh_policy] || EightBall::Providers::RefreshPolicies::Interval.new
    end

    # Returns the current {EightBall::Feature Features}.
    # @return [Array<{EightBall::Feature}>]
    def features
      @policy.refresh { fetch }
      @features
    end

    private

    def fetch
      @features = @marshaller.unmarshall Net::HTTP.get(@uri)
    rescue StandardError => e
      EightBall.logger.error "Failed to fetch data from #{@uri}: #{e.message}"
      @features = []
    end
  end
end
