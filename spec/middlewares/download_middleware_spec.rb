require 'spec_helper'

describe DownloadMiddleware do

  it 'should download the given HTML URL, output the string, and clean up the html file' do
    stack = Middleware::Builder.new do
      use DownloadMiddleware
    end

    url = "http://some.url"
    html_response = double(:body => 'html body')
    HTTParty.stub(:get).with(url).and_return(html_response)

    stack_response = stack.call(:source_url => url)
    File.read(stack_response[:html_path]).should include('html body')
  end

end
