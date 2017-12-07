require_relative '../vocabulary'
require_relative 'parsing_words_module'

module TyranoDsl
  module ParsingWords

    # @!macro word_set_character_stance
    module SetCharacterStance

      include TyranoDsl::ParsingWords::ParsingWordsModule

      # @param [String] character_name
      # @param [String] character_stance
      # @return [void]
      def set_character_stance(character_name, character_stance)
        check_character_exist(context, character_name, character_stance)

        add_parsed_word(
            TyranoDsl::Vocabulary::SET_CHARACTER_STANCE,
            name: character_name,
            stance: character_stance
        )
      end
    end
  end
end
