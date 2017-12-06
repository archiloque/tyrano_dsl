require_relative 'dsl_module'
require_relative '../vocabulary'

module TyranoDsl
  module Dsl

    # @!macro word_display_text
    module DisplayText

      include TyranoDsl::Dsl::DslModule

      # @param [String] character_name
      # @param [String] text
      # @return [void]
      def display_text(character_name, text)
        check_character_exist(context, character_name)
        add_parsed_word(
            TyranoDsl::Vocabulary::DISPLAY_TEXT,
            name: character_name, text: text
        )
      end
    end
  end
end
