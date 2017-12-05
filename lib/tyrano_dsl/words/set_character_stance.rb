require_relative 'words_module'
require_relative '../vocabulary'

module TyranoDsl
  module Words

    # @!macro word_set_character_stance
    class SetCharacterStance

      include TyranoDsl::Words::WordsModule

      # @!macro word_parse
      def parse(context, word_location, parameters)
        validate_parameters_length(
            word_location,
            [
                'the character name',
                'the character stance',
            ],
            parameters)
        character_name = parameters[0]
        character_stance = parameters[1]
        check_character_exist(context, word_location, character_name, character_stance)

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
