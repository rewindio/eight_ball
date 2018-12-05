# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eight_ball/version'

Gem::Specification.new do |spec|
  spec.name          = 'eight_ball'
  spec.version       = EightBall::VERSION
  spec.authors       = ['Rewind.io']
  spec.email         = ['team@rewind.io']

  spec.summary       = ''
  spec.description   = 'Ask questions about flagged features'
  spec.homepage      = 'https://github.com/rewindio/eight_ball'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  ### DEPENDENCIES
  spec.add_dependency 'plissken', '~> 1.2'

  # Development
  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'inch', '~> 0.8'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'minitest-reporters', '~> 1.3'
  spec.add_development_dependency 'mocha', '~> 1.7'
  spec.add_development_dependency 'pry-byebug', '~> 3.6'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'simplecov', '~> 0.16'
  spec.add_development_dependency 'simplecov-console', '~> 0.4'
end
