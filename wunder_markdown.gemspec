# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wunder_markdown/version'

Gem::Specification.new do |spec|
  spec.name          = "wunder_markdown"
  spec.version       = WunderMarkdown::VERSION
  spec.authors       = ["Yannick Schutz"]
  spec.email         = ["yannick.schutz@gmail.com"]
  spec.summary       = "Mardown dump your wunderlists"
  spec.description   = "Mardown dump your wunderlists"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "faraday", "~> 0.8"
  spec.add_runtime_dependency "netrc", "~> 0.7"
end
