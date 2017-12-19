require_relative '../vocabulary'
require_relative 'parsing_words_module'

module TyranoDsl::ParsingWords::SetCharacterStance

  include TyranoDsl::ParsingWords::ParsingWordsModule

  # @param [String] character_name
  # @param [String] character_stance
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def set_character_stance(character_name, character_stance)
    symbolized_stance = symbolize(character_stance)
    check_character_exist(character_name, symbolized_stance)

    add_parsed_word(
        TyranoDsl::Vocabulary::SET_CHARACTER_STANCE,
        name: character_name,
        stance: symbolized_stance
    )
  end

end
