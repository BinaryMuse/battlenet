# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'battlenet/version'

Gem::Specification.new do |s|
  s.name        = "battlenet"
  s.version     = Battlenet::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Brandon Tilley","Espen A. Nilsen","Marv Cool"]
  s.email       = ["brandon@brandontilley.com","post@espennilsen.net","marv@hostin.is"]
  s.homepage    = "https://github.com/BinaryMuse/battlenet"
  s.summary     = %q{Easily consume Blizzard's Community Platform API.}
  s.description = %q{Easily consume Blizzard's Community Platform API.}

  s.add_dependency "ruby-hmac"

  if s.respond_to?(:add_development_dependency)
    s.add_development_dependency "rspec"
  end

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
