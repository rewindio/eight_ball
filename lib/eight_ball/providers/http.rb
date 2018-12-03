# frozen_string_literal: true

module EightBall::Providers
  class Http
    SUPPORTED_SCHEMES = %w[http https].freeze

    def initialize(uri, options = {})
      raise ArgumentError, 'Invalid HTTP/HTTPS URI provided' unless uri =~ URI.regexp(SUPPORTED_SCHEMES)

      @uri = URI.parse uri

      @parser = options[:parser] || EightBall::Parsers::Json.new
      @policy = options[:refresh_policy] || EightBall::Providers::RefreshPolicies::Interval.new
    end

    def features
      @policy.refresh { fetch }
      @features
    end

    private

    def fetch
      @features = @parser.parse Net::HTTP.get(@uri)
    end
  end
end
