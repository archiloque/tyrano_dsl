require_relative '../../elements/character'
require_relative '../../file_actions/clear_directory'
require_relative '../../file_actions/file_copy'
require_relative 'elements_writers_module'

# Write a character
class TyranoDsl::ExportTyrano::ElementsWriters::CharacterWriter

  include TyranoDsl::ExportTyrano::ElementsWriters::ElementsWritersModule

  # @return [Array]
  def init_actions
    [
        TyranoDsl::FileActions::ClearDirectory.new(TyranoDsl::Elements::Character::CHARACTER_DIRECTORY)
    ]
  end

  # @param [TyranoDsl::Elements::Character] character
  # @return [Array]
  def write(character)
    log {"Writing character [#{character.name}]"}
    result = []
    character.stances.each_value do |stance|
      result << TyranoDsl::FileActions::FileCopy.new(
          stance.original_file_name,
          stance.long_target_file_name
      )
    end
    result
  end

end
