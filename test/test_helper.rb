require 'simplecov'
require 'simplecov-console'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new [
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::Console
]
SimpleCov.start do
  add_group 'Conditions', 'lib/eight_ball/conditions'
  add_group 'Providers', 'lib/eight_ball/providers'
  add_group 'Parsers', 'lib/eight_ball/parsers'
  add_filter %r{^/test/}
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'eight_ball'

require 'minitest/autorun'

require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require 'mocha/minitest'

require 'pry'
