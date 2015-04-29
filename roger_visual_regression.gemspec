# coding: utf-8
# lib = File.expand_path('../lib', __FILE__)
# $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
# require '/lib/roger_visual_regression/version'

Gem::Specification.new do |spec|
  spec.name          = "roger_visual_regression"
  spec.version       = "0.1.0"
  spec.authors       = ["Danny Cobussen"]
  spec.email         = ["danny@digitpaint.nl"]

  spec.summary       = %q{TODO: Write a short summary, because Rubygems requires one.}
  spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files = `git ls-files`.split("\n")
  spec.require_paths = ["lib"]

  spec.add_dependency "roger", "~> 0.13", ">= 0.13.0"
  spec.add_dependency "rspec-page-regression", "~> 0.3.0"
  spec.add_dependency "selenium-webdriver"

  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "thor", ["~> 0"]
end
