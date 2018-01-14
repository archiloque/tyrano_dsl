require_relative '../parser'
require_relative '../parsing_context'
require_relative '../tyrano_dsl'
require_relative '../tyrano_exception'
require_relative 'export_game'
require_relative 'writer'

class TyranoDsl::ExportTyrano::Main

  # @param [String] file_path path to the DSL file
  # @return [TyranoDsl::ExportTyrano::WritingContext]
  def run(file_path)
    parsing_context = TyranoDsl::Parser.parse(file_path)
    TyranoDsl::ExportTyrano::Writer.new.write(parsing_context.world, parsing_context.words)
  end

  # @param [TyranoDsl::ExportTyrano::WritingContext] writing_context
  # @param [String] tyrano_project_path
  # @return [void]
  def apply(writing_context, tyrano_project_path)
    writing_context.file_actions.each do |file_action|
      file_action.run(tyrano_project_path)
    end
  end

end