require_relative 'words_module'
require_relative '../vocabulary'

module TyranoDsl
  module Words

    # @!macro word_display_text
    class DisplayText

      include TyranoDsl::Words::WordsModule

      # @!macro word_parse
      def parse(context, word_location, parameters)
        validate_parameters_length(
            word_location,
            [
                'the character name',
                'the text'
            ],
            parameters)
        character_name = parameters[0]
        text = parameters[1]
        check_character_exist(context, word_location, character_name)
        context.add_word(
            TyranoDsl::Vocabulary::DISPLAY_TEXT,
            word_location,
            name: character_name, text: text
        )
      end
    end
  end
end
