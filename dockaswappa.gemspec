# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dockaswappa/version'

Gem::Specification.new do |spec|
  spec.name          = 'capistrano-dockaswappa'
  spec.version       = Dockaswappa::VERSION
  spec.authors       = ['Logan Serman']
  spec.email         = ['loganserman@gmail.com']

  spec.summary       = 'Faciliates the starting/stopping containers with jqilder/nginx-proxy for 0-downtime deployments'
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/lserman/capistrano-dockaswappa"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'

  spec.add_dependency 'capistrano', '~> 3.0'
end
