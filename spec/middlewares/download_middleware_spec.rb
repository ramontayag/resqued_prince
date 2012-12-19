require 'spec_helper'

describe DownloadMiddleware do

  it 'should download the given HTML URL and output the string' do
    stack = Middleware::Builder.new do
      use DownloadMiddleware
    end

    url = "http://some.url"
    response = double(:body => 'html body')
    HTTParty.stub(:get).with(url).and_return(response)
    html = stack.call(:source_url => url)
    html.should == 'html body'
  end

end
