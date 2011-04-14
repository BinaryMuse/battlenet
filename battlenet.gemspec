# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "battlenet"
  s.version     = File.read(File.expand_path('../VERSION', __FILE__)).match(/^(.*)\s*/)[1]
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Brandon Tilley"]
  s.email       = ["brandon@brandontilley.com"]
  s.homepage    = ""
  s.summary     = %q{Easily consume Blizzard's Community Platform API.}
  s.description = %q{Easily consume Blizzard's Community Platform API.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
