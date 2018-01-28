require_relative '../../elements/character'
require_relative '../../file_actions/clear_directory'
require_relative '../../file_actions/file_copy'
require_relative 'base_elements_writers'

# Write a character
class TyranoDsl::ExportTyrano::ElementsWriters::CharacterWriter < TyranoDsl::ExportTyrano::ElementsWriters::BaseElementsWriters

  # @return [Array]
  def init_actions
    [
        TyranoDsl::FileActions::ClearDirectory.new(TyranoDsl::ExportTyrano::Context::CHARACTER_IMAGE_DIRECTORY)
    ]
  end

  # @param [TyranoDsl::ExportTyrano::Context] context
  # @param [TyranoDsl::Elements::Character] character
  # @return [Array]
  def write(context, character)
    log {"Writing character [#{character.name}]"}
    result = []
    character.stances.each_value do |stance|
      result << TyranoDsl::FileActions::FileCopy.new(
          stance.file_name,
          context.stance_long_file_name(character.name, stance.name)
      )
    end
    result
  end

end
