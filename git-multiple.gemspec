# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'git/multiple/version'

Gem::Specification.new do |spec|
  spec.name          = "git-multiple"
  spec.version       = Git::Multiple::VERSION
  spec.authors       = ["Hiroshi IKEGAMI"]
  spec.email         = ["hiroshi.ikegami@magicdrive.jp"]
  spec.summary       = %q{Run the git command in parallel much to multiple git repositories.}
  spec.description   = %q{Run the git command in parallel much to multiple git repositories.}
  spec.homepage      = "https://github.com/magicdrive/ruby-git-multiple"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'thor', '0.19.1'
  spec.add_runtime_dependency 'parallel', '~> 1.3.2'
  spec.add_runtime_dependency 'highline', '~> 1.6.21'
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
end
