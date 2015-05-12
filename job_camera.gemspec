$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "job_camera/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "job_camera"
  s.version     = JobCamera::VERSION
  s.authors     = ["Claudio Fiorini"]
  s.email       = ["claudio.fiorini@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of JobCamera."
  s.description = "TODO: Description of JobCamera."
  s.license     = "MIT"

  s.files = Dir["{lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails', '3.2.1'
  s.add_development_dependency 'combustion', '~> 0.5.3'

end
