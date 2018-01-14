require_relative '../tyrano_dsl'
require_relative '../tyrano_exception'
require_relative 'export_game'
require_relative 'writer'

class TyranoDsl::ExportTyrano::Main

  # @param [TyranoDsl::Elements::World] world
  # @param [Array<TyranoDsl::ParsedWord>] parsed_words
  # @return [TyranoDsl::ExportTyrano::WritingContext]
  def run(world, parsed_words)
    TyranoDsl::ExportTyrano::Writer.new.write(world, parsed_words)
  end

  # @param [TyranoDsl::ExportTyrano::WritingContext] writing_context
  # @param [String] export_path
  # @return [void]
  def apply(writing_context, export_path)
    writing_context.file_actions.each do |file_action|
      file_action.run(export_path)
    end
  end

end