require File.expand_path('../lib/marcel/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.add_dependency 'hutch', '~> 0.15'

  gem.name = 'marcel'
  gem.summary = 'Event-sourcing on top of Hutch'
  gem.description = 'Marcel is a Ruby library based on Hutch' +
                    'for enabling event-sourcing in a service-oriented ' +
                    'architecture, using RabbitMQ.'
  gem.version = Marcel::VERSION.dup
  gem.authors = ['David Jeusette']
  gem.email = ['jeusette.david@gmail.com']
  gem.homepage = 'https://github.com/djeusette/marcel'
  gem.require_paths = ['lib']
  gem.license = 'MIT'

  gem.files = Dir["lib/**/*"] + ["Rakefile", "README.md"]

  # gem.files = `git ls-files`.split("\n")
  # gem.test_files = `git ls-files -- spec/*`.split("\n")
end
