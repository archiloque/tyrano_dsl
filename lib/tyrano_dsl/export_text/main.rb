require_relative '../tyrano_dsl'
require_relative '../tyrano_exception'
require_relative 'export_text'
require_relative 'writer'

class TyranoDsl::ExportText::Main

  # @param [TyranoDsl::Elements::World] _world
  # @param [Array<TyranoDsl::ParsedWord>] parsed_words
  # @return [Array<String>]
  def run(_world, parsed_words)
    TyranoDsl::ExportText::Writer.new.write(parsed_words)
  end

  # @param [Array<String>] content
  # @param [String] _export_path
  # @return [void]
  def apply(content, _export_path)
    STDOUT << "\n\nGame content :\n"
    content.each do |entry|
      STDOUT << entry
    end
  end

end