# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'p4/version'

Gem::Specification.new do |spec|
  spec.name          = "p4"
  spec.version       = P4::VERSION
  spec.authors       = ["Ruijia Li"]
  spec.email         = ["ruijia.li@gmail.com"]
  spec.description   = %q{p4 command wrapper with some custom functions for easy use}
  spec.summary       = %q{p4 command wrapper with some custom functions for easy use}
  spec.homepage      = "https://github.com/rli9/p4"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
