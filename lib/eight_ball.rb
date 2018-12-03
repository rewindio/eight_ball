# frozen_string_literal: true

require 'eight_ball/version'
require 'eight_ball/feature'

require 'eight_ball/conditions/conditions'
require 'eight_ball/conditions/base'

require 'eight_ball/conditions/always'
require 'eight_ball/conditions/list'
require 'eight_ball/conditions/never'
require 'eight_ball/conditions/range'

require 'eight_ball/parsers/json'

require 'eight_ball/providers/static'

module EightBall
  def self.provider=(provider)
    @@provider = provider
  end

  def self.enabled?(name, options = {})
    feature = @@provider.features.find { |f| f.name == name }
    return false unless feature

    feature.enabled? options
  end

  def self.disabled?(name, options = {})
    !enabled? name, options
  end

  def self.with(name, options = {})
    return false unless block_given?
    yield if enabled? name, options
  end
end
