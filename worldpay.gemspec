# -*- encoding: utf-8 -*-
require File.expand_path("../lib/worldpay/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "worldpay"
  s.version     = Worldpay::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Paul Springett']
  s.email       = ['paul@paulspringett.name']
  s.homepage    = "http://rubygems.org/gems/worldpay"
  s.summary     = "TODO: Write a gem summary"
  s.description = "TODO: Write a gem description"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "worldpay"

  s.add_development_dependency "bundler", ">= 1.0.0"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
