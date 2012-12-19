require 'spec_helper'

describe PdfWorker do

  it 'should listen to the :resqued_prince queue' do
    PdfWorker.instance_variable_get("@queue").should == :resqued_prince
  end

  describe ".process" do

    it "should fetch the input string, convert it to PDF, and then upload it"

  end

end
