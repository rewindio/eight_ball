# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eight_ball/version'

Gem::Specification.new do |spec|
  spec.name          = 'eight_ball'
  spec.version       = EightBall::VERSION
  spec.authors       = ['Rewind.io']
  spec.email         = ['team@rewind.io']

  spec.summary       = 'The most cost efficient way to flag features'
  spec.description   = 'Ask questions about flagged features'
  spec.homepage      = 'https://github.com/rewindio/eight_ball'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 2.5.0'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|.github|examples)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  ### DEPENDENCIES
  spec.add_dependency 'plissken', '1.3.0'

  # Development
  spec.add_development_dependency 'bundler', '1.17.2'
  spec.add_development_dependency 'inch', '0.8.0'
  spec.add_development_dependency 'minitest', '5.11.3'
  spec.add_development_dependency 'minitest-reporters', '1.3.5'
  spec.add_development_dependency 'mocha', '1.7.0'
  spec.add_development_dependency 'pry', '0.12.2'
  spec.add_development_dependency 'pry-byebug', '3.8.0'
  spec.add_development_dependency 'rake', '12.3.3'
  spec.add_development_dependency 'simplecov', '0.16.1'
  spec.add_development_dependency 'simplecov-console', '0.4.2'
end
