require_relative 'export_dsl'
require_relative 'writer'

class TyranoDsl::ExportDsl::Main

  # @param [TyranoDsl::Elements::World] world
  # @param [Array<TyranoDsl::ParsedWord>] parsed_words
  # @return [Array]
  def run(world, parsed_words)
    TyranoDsl::ExportDsl::Writer.new.run(world, parsed_words)
  end

  # @param [Array] file_actions
  # @param [String] export_path
  # @return [void]
  def apply(file_actions, export_path)
    file_actions.each do |file_action|
      file_action.run(export_path)
    end
  end

end