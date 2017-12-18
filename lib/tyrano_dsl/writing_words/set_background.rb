require_relative '../elements/background'
require_relative 'writing_words_module'

class TyranoDsl::WritingWords::SetBackground

  def run(writing_context, world, word_location, parameters)
    background = world.backgrounds[parameters[:name]]
    writing_context.append_content(
        word_location,
        "[bg storage=\"#{background.target_short_file_name}\" time=\"1000\"]"
    )
    writing_context.add_asset_loading(
        word_location,
        background.target_long_file_name
    )
  end

end
