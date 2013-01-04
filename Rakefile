APP_ENV = ENV['APP_ENV'] || 'development'
$: << File.join(File.dirname(__FILE__), 'lib')
require File.join(File.dirname(__FILE__), 'config', 'initializer')
require 'resque/tasks'

task "resque:setup" do
  root_dir = File.dirname(__FILE__)
  config_path = File.join(root_dir, 'config', 'resque.yml')
  resque_config = YAML.load_file(config_path)
  Resque.redis = resque_config[APP_ENV]
end
