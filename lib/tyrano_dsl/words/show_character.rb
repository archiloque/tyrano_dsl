require_relative 'words_module'
require_relative '../vocabulary'

module TyranoDsl
  module Words

    # @!macro word_show_character
    module ShowCharacter

      include TyranoDsl::Words::WordsModule

      # @!macro word_parse
      def show_character(character_name, character_stance)
        check_character_exist(context, character_name, character_stance)
        context.add_word(
            TyranoDsl::Vocabulary::SHOW_CHARACTER,
            word_location,
            name: character_name,
            stance: character_stance
        )
      end
    end
  end
end
