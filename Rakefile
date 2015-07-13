require 'rspec/core/rake_task'
require 'hutch'
require 'marcel'

desc "Run the test suite"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = FileList['spec/**/*_spec.rb']
  t.rspec_opts = %w(--color --format doc)
end

task :default => :spec

task :test do
  config = {
    mq_username: 'guest',
    mq_password: 'guest',
    mq_host: 'localhost',
    mq_port: 5672,
    mq_exchange: 'messages',
    autoload_rails: false
  }

  options = {
    enable_http_api_use: false
  }

  Marcel.initialize(options, config)
  Marcel.start("oembed.request")

end

task :produce do
  ruby "./produce.rb"
end
