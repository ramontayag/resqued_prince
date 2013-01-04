require 'spec_helper'

describe UploadMiddleware do
  it "should upload the pdf path to the destination url" do
    stack = Middleware::Builder.new do
      use UploadMiddleware
    end

    HTTMultiParty.should_receive(:post).
      with("http://post.com", :query => { :file => 'tmp/sample.pdf' })

    stack_response = stack.call(:pdf_path => "tmp/sample.pdf",
                                :destination_url => 'http://post.com')

  end
end
