require_relative '../../elements/background'
require_relative '../../file_actions/clear_directory'
require_relative '../../file_actions/file_copy'
require_relative 'base_writer'

# Write a background
class TyranoDsl::ExportTyrano::Writers::Background < TyranoDsl::ExportTyrano::Writers::BaseWriter

  # @return [Array<TyranoDsl::FileActions::BaseFileAction>]
  def init_actions
    [
        TyranoDsl::FileActions::ClearDirectory.new(TyranoDsl::ExportTyrano::Context::BACKGROUND_IMAGE_DIRECTORY)
    ]
  end

  # @param [TyranoDsl::ExportTyrano::Context] context
  # @param [TyranoDsl::Elements::Background] background
  # @return [Array<TyranoDsl::FileActions::BaseFileAction>]
  def write(context, background)
    log {"Writing background [#{background.name}]"}
    [
        TyranoDsl::FileActions::FileCopy.new(
            background.image_path,
            context.backgrounds_long_file_names[background.name]
        )
    ]
  end

end
