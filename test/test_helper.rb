$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'eight_ball'

require 'minitest/autorun'

require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require 'mocha/minitest'

require 'pry'
