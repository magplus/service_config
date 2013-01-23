# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'service_config/version'

Gem::Specification.new do |gem|
  gem.name          = "service_config"
  gem.version       = ServiceConfig::VERSION
  gem.authors       = ["Karl Eklund", "Mikael Amborn", "Mike Burns"]
  gem.email         = ["info@magplus.com"]
  gem.description   = %q{Configure your values using the environment, with fallbacks}
  gem.summary       = %q{Configure your values using the environment, with fallbacks}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rake'
end
