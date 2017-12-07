require_relative '../vocabulary'
require_relative 'parsing_words_module'

module TyranoDsl
  module ParsingWords

    module JumpTo

      include TyranoDsl::ParsingWords::ParsingWordsModule

      # @param [String] scene_name
      # @param [String, nil] label_name
      # @return [void]
      def jump_to(scene_name, label_name = nil)
        add_parsed_word(
            TyranoDsl::Vocabulary::JUMP_TO,
            name: scene_name,
            label: label_name
        )
      end
    end
  end
end
