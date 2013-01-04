require 'bundler'
Bundler.require(:default, APP_ENV.to_sym)
require 'resque'
require 'httparty'
require 'middleware'
middleware_dir = File.join(File.dirname(__FILE__), '..', 'lib', 'middlewares')
Dir.glob(File.join(middleware_dir, '**')).each do |f|
  require f
end
require 'workers/pdf_worker'
require 'tapa_prince'
