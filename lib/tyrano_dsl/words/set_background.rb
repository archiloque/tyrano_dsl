require_relative 'words_module'
require_relative '../vocabulary'

module TyranoDsl
  module Words

    # @!macro word_set_background
    class SetBackground

      include TyranoDsl::Words::WordsModule

      # @!macro word_parse
      def parse(context, word_location, parameters)
        validate_parameters_length(
            word_location,
            [
                'the background name',
            ],
            parameters)
        background_name = parameters[0]

        unless context.world.backgrounds.key? background_name
          raise ::TyranoDsl::TyranoException, "Line #{word_location.lineno} unknown background [#{background_name}], currently defined: #{context.world.backgrounds.keys.sort.join(', ')}"
        end
        context.add_word(
            TyranoDsl::Vocabulary::SET_BACKGROUND,
            word_location,
            name: background_name
        )
      end
    end
  end
end
