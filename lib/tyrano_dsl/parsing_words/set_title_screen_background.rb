require_relative '../vocabulary'
require_relative 'parsing_words_module'

module TyranoDsl::ParsingWords::SetTitleScreenBackground

  include TyranoDsl::ParsingWords::ParsingWordsModule

  # @param [String] background_name
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def set_title_screen_background(background_name)
    unless context.world.backgrounds.key? background_name
      raise TyranoDsl::TyranoException, "Line #{word_location[0].lineno} unknown background [#{background_name}], currently defined: #{context.world.backgrounds.keys.sort.join(', ')}"
    end
    if context.world.title_screen.background
      raise TyranoDsl::TyranoException, "Line #{word_location[0].lineno} title screen background already defined"
    end
    context.world.title_screen.background = background_name
    add_parsed_word(
        TyranoDsl::Vocabulary::SET_TITLE_SCREEN_BACKGROUND,
        name: background_name
    )
  end

end
