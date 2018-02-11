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

    characters = TyranoDsl::ImportTyrano::Readers::Characters.new.read(file_accessor)
    context = TyranoDsl::ImportTyrano::Context.new(directory_path, characters, file_accessor)
    result_variables = TyranoDsl::ImportTyrano::Readers::Variables.new.read(file_accessor)

    result_scenes = context.process_scenes
    result_characters = context.process_characters
    result_variables + result_characters + result_scenes
  end

end