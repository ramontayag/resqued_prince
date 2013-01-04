module TapaPrince
  extend self

  def convert(html, options={})
    converter = TapaPrince::Converter.new(html, options)
    converter.convert
  end

end

require 'tapa_prince/converter'
