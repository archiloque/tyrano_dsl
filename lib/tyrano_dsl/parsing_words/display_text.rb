require_relative '../vocabulary'
require_relative 'parsing_words_module'

module TyranoDsl::ParsingWords::DisplayText

  include TyranoDsl::ParsingWords::ParsingWordsModule

  # @param [String|nil] character_name
  # @param [String] text
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def display_text(character_name, text)
    if character_name
      check_character_exist(context, character_name)
    end
    add_parsed_word(
        TyranoDsl::Vocabulary::DISPLAY_TEXT,
        character_name: character_name, text: text
    )
  end

end
