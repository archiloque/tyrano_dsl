require_relative '../vocabulary'
require_relative 'parsing_words_module'

module TyranoDsl
  module ParsingWords

    module DisplayText

      include TyranoDsl::ParsingWords::ParsingWordsModule

      # @param [String] character_name
      # @param [String] text
      # @return [void]
      def display_text(character_name, text)
        check_character_exist(context, character_name)
        add_parsed_word(
            TyranoDsl::Vocabulary::DISPLAY_TEXT,
            character_name: character_name, text: text
        )
      end
    end
  end
end
