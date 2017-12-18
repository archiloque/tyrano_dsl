require_relative '../vocabulary'
require_relative 'parsing_words_module'

module TyranoDsl::ParsingWords::ShowCharacter

  include TyranoDsl::ParsingWords::ParsingWordsModule

  # @param [String] character_name
  # @param [String] character_stance
  # @param [Integer] left
  # @param [Integer] top
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def show_character(character_name, character_stance, left, top)
    symbolized_stance = symbolize(character_stance)
    check_character_exist(context, character_name, symbolized_stance)
    add_parsed_word(
        TyranoDsl::Vocabulary::SHOW_CHARACTER,
        name: character_name,
        stance: symbolized_stance,
        left: left,
        top: top
    )
  end

end
