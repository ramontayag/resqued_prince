require 'spec_helper'

describe HtmlToPdfMiddleware do

  it 'should convert a HTML from a file path and output its PDF path' do
    stack = Middleware::Builder.new do
      use HtmlToPdfMiddleware
    end

    sample_html = File.open("tmp/sample.html", "w") do |f|
      f.puts("<html />")
    end

    stack_response = stack.call(:html_path => "tmp/sample.html")
    File.should exist(stack_response[:pdf_path])
  end

  describe '#before_call' do
    it 'should merge the pdf_path with the env' do
      middleware = described_class.new(double)
      sample_html = File.open("tmp/sample.html", "w") do |f|
        f.puts("<html />")
      end
      env = middleware.before_call(:html_path => "tmp/sample.html")
      env[:pdf_path].should_not be_nil
    end
  end

end
