require_relative '../parser'
require_relative '../parsing_context'
require_relative '../tyrano_dsl'
require_relative '../tyrano_exception'
require_relative 'export_game'
require_relative 'writer'

class TyranoDsl::ExportGame::Main

  # @param [String] file_path path to the DSL file
  # @return [TyranoDsl::ExportGame::WritingContext]
  def run(file_path)
    parsing_context = TyranoDsl::ParsingContext.new
    parser = TyranoDsl::Parser.new(parsing_context, file_path)
    parser.include_file(file_path)
    TyranoDsl::ExportGame::Writer.new.write(parsing_context.world, parsing_context.words)
  end

  # @param [TyranoDsl::ExportGame::WritingContext] writing_context
  # @param [String] tyrano_project_path
  # @return [void]
  def apply(writing_context, tyrano_project_path)
    writing_context.file_actions.each do |file_action|
      file_action.run(tyrano_project_path)
    end
  end

end