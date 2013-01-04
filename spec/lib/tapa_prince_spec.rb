require 'spec_helper'

describe TapaPrince do

  describe '.convert' do
    it 'should delegate the work to a TapaPrince::Converter instance' do
      options = {}
      converter = double
      TapaPrince::Converter.stub(:new).with('<html/>', options).
        and_return(converter)
      converter.should_receive(:convert)
      described_class.convert('<html/>', options)
    end
  end

end
