require_relative 'context'
require_relative 'import_tyrano'
require_relative 'file_accessor'
require_relative 'readers/characters'
require_relative 'readers/variables'

class TyranoDsl::ImportTyrano::Main

  # @param [String] directory_path path to the tyrano project
  # @return [Array<TyranoDsl::ParsedWord>]
  # @raise [TyranoDsl::TyranoException]
  def run(directory_path)
    file_accessor = TyranoDsl::ImportTyrano::FileAccessor.new(directory_path)
    context = TyranoDsl::ImportTyrano::Context.new(directory_path)

    result = []

    result.concat(TyranoDsl::ImportTyrano::Readers::Characters.new.read(file_accessor, context))
    result.concat(TyranoDsl::ImportTyrano::Readers::Variables.new.read(file_accessor))
    result
  end

end