require 'spec_helper'

describe PdfWorker do

  it 'should listen to the :resqued_prince queue' do
    PdfWorker.instance_variable_get("@queue").should == :resqued_prince
  end

  describe ".process" do

    it "should fetch the input string, convert it to PDF, and upload it" do
      response = described_class.
        process(:source_url => "http://127.0.0.1:1234/source",
                :destination_url => "http://127.0.0.1:1234/callback")
      response[:upload_status].should == 201
    end

  end

  describe '.stack' do
    it 'should use the download, convert, and upload middlewares' do
      stack = double
      Middleware::Builder.stub(:new).and_return(stack)
      stack.should_receive(:use).with(DownloadMiddleware).once.ordered
      stack.should_receive(:use).with(HtmlToPdfMiddleware).once.ordered
      stack.should_receive(:use).with(UploadMiddleware).once.ordered
      described_class.stack.should == stack
    end
  end

end
