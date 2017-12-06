require_relative 'words_module'
require_relative '../vocabulary'

module TyranoDsl
  module Words

    # @!macro word_display_text
    module DisplayText

      include TyranoDsl::Words::WordsModule

      def display_text(character_name, text)
        check_character_exist(context, character_name)
        context.add_word(
            TyranoDsl::Vocabulary::DISPLAY_TEXT,
            word_location,
            name: character_name, text: text
        )
      end
    end
  end
end
