$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "sortify/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sortify"
  s.version     = Sortify::VERSION
  s.authors     = ["Melody"]
  s.email       = ["meltheadorable@gmail.com"]
  s.homepage    = "https://github.com/meltheadorable/sortify"
  s.summary     = "Sortify helps you handle user-provided sort options in Rails apps."
  s.description = "Sortify acts as a wrapper around ActiveRecord scopes, providing a tiny bit of extra functionality to keep track of valid sorting options and call them from user input."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 4.2.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec"
end
