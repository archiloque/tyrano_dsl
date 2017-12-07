require_relative '../vocabulary'
require_relative 'parsing_words_module'

module TyranoDsl
  module ParsingWords

    module ShowCharacter

      include TyranoDsl::ParsingWords::ParsingWordsModule

      # @param [String] character_name
      # @param [String] character_stance
      # @param [Integer] left
      # @param [Integer] top
      # @return [void]
      def show_character(character_name, character_stance, left, top)
        check_character_exist(context, character_name, character_stance)
        add_parsed_word(
            TyranoDsl::Vocabulary::SHOW_CHARACTER,
            name: character_name,
            stance: character_stance,
            left: left,
            top: top
        )
      end
    end
  end
end
