require_relative 'words_module'
require_relative '../vocabulary'

module TyranoDsl
  module Words

    # @!macro word_set_character_stance
    module SetCharacterStance

      include TyranoDsl::Words::WordsModule

      def set_character_stance(character_name, character_stance)
        check_character_exist(context, character_name, character_stance)

        context.add_word(
            TyranoDsl::Vocabulary::SET_CHARACTER_STANCE,
            word_location,
            name: character_name,
            stance: character_stance
        )
      end
    end
  end
end
