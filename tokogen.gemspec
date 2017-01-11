# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tokogen/version'

Gem::Specification.new do |spec|
  spec.name          = "tokogen"
  spec.version       = Tokogen::VERSION
  spec.authors       = ["MOZGIII"]
  spec.email         = ["mike-n@narod.ru"]

  spec.summary       = %q{Generates random tokens with fixed length and customizeable alphabet.}
  spec.description   = %q{A ruby gem that allows you to generate customizeable random tokens.}
  spec.homepage      = "https://github.com/MOZGIII/tokogen"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
