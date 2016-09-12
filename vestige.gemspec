# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vestige/version'

Gem::Specification.new do |spec|
  spec.name          = "vestige"
  spec.version       = Vestige::VERSION
  spec.authors       = ["Pavel Penkov"]
  spec.email         = ["ebonfortress@gmail.com"]

  spec.summary       = "Distributed tracing for Rails applications"
  spec.description   = "Distributed tracing for Rails applications"
  spec.homepage      = "https://github.com/PavelPenkov/vestige"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
