module TapaPrince
  extend self

  def from_string_to_file
    converter = TapaPrince::Converter.new
    converter.from_string_to_file
  end

end

require 'tapa_prince/converter'
