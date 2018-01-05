require_relative '../parser'
require_relative '../parsing_context'
require_relative '../tyrano_dsl'
require_relative '../tyrano_exception'
require_relative 'export_text'
require_relative 'writer'

class TyranoDsl::ExportText::Main

  # @param [String] file_path path to the DSL file
  # @return [Array<String>]
  def run(file_path)
    parsing_context = TyranoDsl::Parser.parse(file_path)
    TyranoDsl::ExportText::Writer.new.write(parsing_context.words)
  end

  # @param [Array<String>] content
  # @param [String] _tyrano_project_path
  # @return [void]
  def apply(content, _tyrano_project_path)
    STDOUT << "\n\nGame content :\n"
    content.each do |entry|
      STDOUT << entry
    end
  end

end