$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "etabliocms_actualities/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |gem|
  gem.name        = "etabliocms_actualities"
  gem.version     = EtabliocmsActualities::VERSION
  gem.authors     = ["papricek"]
  gem.email       = ["patrikjira@gmail.com"]
  gem.homepage    = "https://github.com/papricek/etabliocms_actualities"
  gem.summary     = "Small CMS - module for actualities"
  gem.description = "Small CMS - module for actualities"

  gem.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  gem.test_files = Dir["test/**/*"]

  gem.add_dependency "rails", "~> 3.2.1"
  gem.add_dependency "etabliocms_core"
  gem.add_dependency "awesome_nested_set", '2.1.2'

  gem.add_development_dependency "sqlite3"
end
