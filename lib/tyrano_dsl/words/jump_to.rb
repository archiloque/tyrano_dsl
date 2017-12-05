require_relative 'words_module'
require_relative '../vocabulary'

module TyranoDsl
  module Words

    # @!macro word_jump_to
    class JumpTo

      include TyranoDsl::Words::WordsModule

      # @!macro word_parse
      def parse(context, word_location, parameters)
        validate_parameters_length(
            word_location,
            [
                'the scene name',
                'the label name'
            ],
            parameters)
        scene_name = parameters[0]
        label_name = parameters[1]
        context.add_word(
            TyranoDsl::Vocabulary::JUMP_TO,
            word_location,
            name: scene_name,
            label: label_name
        )
      end
    end
  end
end
