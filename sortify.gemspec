$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "sortify/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sortify"
  s.version     = Sortify::VERSION
  s.authors     = ["Melody"]
  s.email       = ["meltheadorable@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Sortify."
  s.description = "TODO: Description of Sortify."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec"
end
