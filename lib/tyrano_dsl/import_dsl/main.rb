require_relative 'import_dsl'
require_relative 'parser'

class TyranoDsl::ImportDsl::Main

  # @param [String] file_path path to the DSL file
  # @return [TyranoDsl::ExportTyrano::Context]
  # @raise [TyranoDsl::TyranoException]
  def run(file_path)
    context = TyranoDsl::ImportDsl::Parser.parse(file_path)
    context.words
  end

end