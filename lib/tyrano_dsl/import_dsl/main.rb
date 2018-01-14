require_relative 'import_dsl'
require_relative 'parser'

class TyranoDsl::ImportDsl::Main

  # @param [String] file_path path to the DSL file
  # @return [TyranoDsl::ExportTyrano::WritingContext]
  # @raise [TyranoDsl::TyranoException]
  def run(file_path)
    parsing_context = TyranoDsl::ImportDsl::Parser.parse(file_path)
    {
        world: parsing_context.world,
        words: parsing_context.words,
    }
  end

end