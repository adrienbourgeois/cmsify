$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cmsify/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cmsify"
  s.version     = Cmsify::VERSION
  s.authors     = ["Adrien Bourgeois"]
  s.email       = ["adrienfrancis.bourgeois@gmail.com"]
  s.homepage    = "https://github.com/adrienbourgeois/cmsify"
  s.summary     = "Make any rails model field editable"
  s.description = "Provide generic CMS models, a restful API and helpers method to enable CMS features on any part of your rails application"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.5.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency('pry')
  s.add_development_dependency('factory_girl_rails', '~> 4.2')
  s.add_development_dependency('rspec-mocks', '~> 3.0')
  s.add_development_dependency('rspec-rails', '~> 3.0')
  s.add_development_dependency('shoulda', '~> 3.5')
  s.add_development_dependency('shoulda-matchers', '~> 2.4')
  s.add_development_dependency('faker')

  s.add_dependency "rails", "~> 4.2.0"
  s.add_dependency('paperclip', '~> 4.2.1')
  s.add_dependency('railties', '>= 4.0.0')
end
