require_relative '../vocabulary'
require_relative 'parsing_words_module'

module TyranoDsl
  module ParsingWords

    module HideCharacter

      include TyranoDsl::ParsingWords::ParsingWordsModule

      # @param [String] character_name
      # @return [void]
      # @raise [TyranoDsl::TyranoException]
      def hide_character(character_name)
        check_character_exist(context, character_name)
        add_parsed_word(
            TyranoDsl::Vocabulary::HIDE_CHARACTER,
            name: character_name
        )
      end
    end
  end
end
