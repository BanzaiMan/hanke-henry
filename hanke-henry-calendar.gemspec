# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hanke-henry/version'

Gem::Specification.new do |gem|
  gem.name          = "hanke-henry"
  gem.version       = HankeHenry::VERSION
  gem.authors       = ["Hirotsugu Asari"]
  gem.email         = ["asari.ruby@gmail.com"]
  gem.description   = %q{Date and DateTime extensions for the Hanke-Henry Calendar}
  gem.summary       = gem.description
  gem.homepage      = "http://github.com/BanzaiMan/hanke-henry-calendar"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_development_dependency 'rspec', '>= 2.0'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'autotest'
end
