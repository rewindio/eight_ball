# frozen_string_literal: true

module EightBall::Providers
  class Http
    SUPPORTED_SCHEMES = %w[http https].freeze

    def initialize(uri, options = {})
      raise Exception, 'Invalid HTTP/HTTPS URI provided' unless uri =~ URI.regexp(SUPPORTED_SCHEMES)

      @uri = URI.parse uri
      @parser = options[:parser] || EightBall::Parsers::Json.new
    end

    def features
      @features ||= fetch
    end

    private

    def fetch
      @parser.parse(Net::HTTP.get @uri)
    end
  end
end
