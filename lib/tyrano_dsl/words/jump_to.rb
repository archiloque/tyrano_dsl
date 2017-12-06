require_relative 'words_module'
require_relative '../vocabulary'

module TyranoDsl
  module Words

    # @!macro word_jump_to
    module JumpTo

      include TyranoDsl::Words::WordsModule

      # @param [String] scene_name
      # @param [String, nil] label_name
      # @return [void]
      def jump_to(scene_name , label_name = nil)
        add_parsed_word(
            TyranoDsl::Vocabulary::JUMP_TO,
            name: scene_name,
            label: label_name
        )
      end
    end
  end
end
