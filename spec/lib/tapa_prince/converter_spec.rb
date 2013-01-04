require 'spec_helper'

describe TapaPrince::Converter do

  describe '#convert' do
    it 'should use a random pdf file name by default' do
      converter = described_class.new("<html/>")
      file = converter.convert
      File.should exist(file)
    end

    context 'when the command fails' do
      it "should throw an exception" do
        converter = described_class.new("<html/>")
        converter.stub(:convert_command).and_return('asdkajshdjkah')
        expect { converter.convert }.to raise_error
      end
    end
  end

  describe '#convert_command' do
    it 'should convert the given html to a pdf file' do
      converter = described_class.new("<html/>")
      command = converter.convert_command
      command.should match(/-o [\/\w]+\.pdf/)
    end

    it 'should output to random file names' do
      converter = described_class.new("<html/>")
      command_1 = converter.convert_command

      converter = described_class.new("<html/>")
      command_2 = converter.convert_command

      file_1 = command_1.match(/-o ([\/\w]+)/)[1]
      file_2 = command_2.match(/-o ([\/\w]+)/)[1]

      file_1.should_not == file_2
    end

    it 'should add the css files by default' do
      html = <<-EOF
        <html>
          <head>
            <link href="/a.css" media="screen" rel="stylesheet" type="text/css" />
            <link href="/b.css" media="screen" rel="stylesheet" type="text/css" />
          </head>
        </html>
      EOF
      converter = described_class.new(html)
      command = converter.convert_command
      command.should match('-s /a.css -s /b.css')
    end

    context 'when options include host' do
      it 'should make stylesheets absolute urls' do
        html = <<-EOF
          <html>
            <head>
              <link href="/a.css" media="screen" rel="stylesheet" type="text/css" />
            </head>
          </html>
        EOF
        converter = described_class.new(html, host: 'http://hi.com/')
        command = converter.convert_command
        command.should include('-s http://hi.com/a.css')
      end
    end
  end

end
