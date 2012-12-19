require 'bundler'
Bundler.setup(:default, APP_ENV.to_sym)
require 'resque'
require 'httparty'
require 'middleware'
require 'middlewares/download_middleware'
require 'workers/pdf_worker'
