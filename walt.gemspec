# -*- encoding: utf-8 -*-
require File.expand_path('../lib/walt/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = "walt"
  s.version     = Walt::VERSION
  s.authors     = ["Clay Allsopp"]
  s.email       = ["clay.allsopp@gmail.com"]
  s.homepage    = "https://github.com/clayallsopp/walt"
  s.summary     = "Fast, frictionless iOS animations"
  s.description = "Fast, frictionless iOS animations"

  s.files         = `git ls-files`.split($\)
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_dependency "bubble-wrap", ">= 1.1.4"
  s.add_dependency "afmotion", ">= 0.4"
  s.add_dependency "motion-cocoapods", "~> 1.2.1"
  s.add_development_dependency 'rake'
end