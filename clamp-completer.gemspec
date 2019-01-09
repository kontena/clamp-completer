
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "clamp/completer/version"

Gem::Specification.new do |spec|
  spec.name          = "clamp-completer"
  spec.version       = Clamp::Completer::VERSION
  spec.authors       = ["Kontena, Inc"]
  spec.email         = ["info@kontena.io"]

  spec.summary       = %q{Automatically generate shell auto-completion scripts for clamp based cli tools}
  spec.homepage      = "https://github.com/kontena/clamp-completer"

  spec.files         = Dir["lib/**/*.{rb,erb}", "README.md", "LICENSE", "clamp-completer.gemspec"]

  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "clamp"

  spec.add_development_dependency "bundler", ">= 1.17"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 0.62"
end
