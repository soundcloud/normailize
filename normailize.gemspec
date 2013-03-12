# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'normailize/version'

Gem::Specification.new do |spec|
  spec.name          = "normailize"
  spec.version       = Normailize::VERSION
  spec.authors       = ["Michael Henriksen"]
  spec.email         = ["michenriksen87@gmail.com"]
  spec.description   = %q{Normalize emails like J.oh.n+sneaky@gmail.com into john@gmail.com}
  spec.summary       = %q{Normalize emails like J.oh.n+sneaky@gmail.com into john@gmail.com}
  spec.homepage      = "https://github.com/soundcloud/normailize"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
