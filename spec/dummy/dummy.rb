require 'rubygems'
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../../Gemfile', __FILE__)
require 'bundler/setup'
Bundler.require(:development)

get '/source' do
  content_type "text/html"
  <<-EOF
  <html>
    <body>
      <p>Test</p>
    </body>
  </html>
  EOF
end

post '/callback' do
  if params[:file]
    status 201
  else
    status 500
  end
end
