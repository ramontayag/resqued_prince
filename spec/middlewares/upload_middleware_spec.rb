require 'spec_helper'

describe UploadMiddleware do
  it "should upload the pdf path to the destination url" do
    stack = Middleware::Builder.new do
      use UploadMiddleware
    end

    response = double(code: 201)
    HTTMultiParty.should_receive(:post).
      with("http://post.com", :query => { :file => 'tmp/sample.pdf' }).
      and_return(response)

    stack_response = stack.call(:pdf_path => "tmp/sample.pdf",
                                :destination_url => 'http://post.com')
    stack_response[:upload_status].should == 201
  end
end
