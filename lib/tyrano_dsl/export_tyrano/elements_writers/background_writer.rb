require_relative '../../elements/background'
require_relative '../file_actions/clear_directory'
require_relative '../file_actions/file_copy'
require_relative 'elements_writers_module'

# Write a background
class TyranoDsl::ExportTyrano::ElementsWriters::BackgroundWriter

  include TyranoDsl::ExportTyrano::ElementsWriters::ElementsWritersModule

  # @return [Array]
  def init_actions
    [
        TyranoDsl::ExportTyrano::FileActions::ClearDirectory.new(TyranoDsl::Elements::Background::BACKGROUND_DIRECTORY)
    ]
  end

  # @param [TyranoDsl::Elements::Background] background
  # @return [Array]
  def write(background)
    log {"Writing background [#{background.name}]"}
    [
        TyranoDsl::ExportTyrano::FileActions::FileCopy.new(
            background.image_path,
            background.target_long_file_name
        )
    ]
  end

end
