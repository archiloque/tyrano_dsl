require_relative '../../elements/character'
require_relative '../../file_actions/clear_directory'
require_relative '../../file_actions/file_copy'
require_relative '../../tyrano_constants'
require_relative 'base_writer'

# Write a character
class TyranoDsl::ExportTyrano::Writers::Character < TyranoDsl::ExportTyrano::Writers::BaseWriter

  # @return [Array<TyranoDsl::FileActions::BaseFileAction>]
  def init_actions
    [
        TyranoDsl::FileActions::ClearDirectory.new(File.join(TyranoDsl::TyranoConstants::CHARACTER_IMAGE_FULL_DIRECTORY))
    ]
  end

  # @param [TyranoDsl::ExportTyrano::Context] context
  # @param [TyranoDsl::Elements::Character] character
  # @return [Array<TyranoDsl::FileActions::BaseFileAction>]
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
