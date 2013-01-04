class TapaPrince::Converter
  def initialize(html, options={})
    @html = html
    @host = options[:host]
    random_str = ::SecureRandom.hex(16)
    @file_path = "tmp/#{random_str}.pdf"
  end

  def convert
    pipe = IO.popen(convert_command, "w+")
    pipe.puts(@html)
    pipe.close
    @file_path
  end

  def convert_command
    "prince - #{stylesheet_switches} -o #{@file_path}"
  end

  def output_file
  end

  private

  def stylesheet_switches
    doc = Nokogiri::XML(@html)
    stylesheet_paths = doc.css('link[rel=stylesheet]').map do |link_tag|
      if @host
        url = URI.parse(@host)
        url.path = link_tag[:href]
        url
      else
        link_tag[:href]
      end
    end
    stylesheet_paths.map do |path|
      "-s #{path}"
    end.join(' ')
  end

end
