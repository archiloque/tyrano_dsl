require_relative 'base_word'
require_relative '../../elements/background'
require_relative 'words'

class TyranoDsl::ExportTyrano::Words::SetBackground < TyranoDsl::ExportTyrano::Words::BaseWord

  # @param [TyranoDsl::ExportTyrano::Context] context
  # @param [TyranoDsl::Elements::World] world
  # @param [Hash{Symbol=>Object}] parameters
  # @option parameters [String] :background_name
  def run(context, world, parameters)
    background_name = parameters[:background_name]
    context.append_content(
        "[bg storage=\"#{context.backgrounds_short_file_names[background_name]}\" time=\"1000\"]"
    )
    context.add_asset_loading(
        context.backgrounds_long_file_names[background_name]
    )
  end

end
