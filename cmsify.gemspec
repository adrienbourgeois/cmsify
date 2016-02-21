$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cmsify/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cmsify"
  s.version     = Cmsify::VERSION
  s.authors     = ["Adrien Bourgeois"]
  s.email       = ["adrienfrancis.bourgeois@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Cmsify."
  s.description = "TODO: Description of Cmsify."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.5.1"

  s.add_development_dependency "sqlite3"
end
