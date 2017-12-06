require_relative 'dsl_module'
require_relative '../vocabulary'

module TyranoDsl
  module Dsl

    # @!macro word_show_character
    module ShowCharacter

      include TyranoDsl::Dsl::DslModule

      # @param [String] character_name
      # @param [String] character_stance
      # @return [void]
      def show_character(character_name, character_stance)
        check_character_exist(context, character_name, character_stance)
        add_parsed_word(
            TyranoDsl::Vocabulary::SHOW_CHARACTER,
            name: character_name,
            stance: character_stance
        )
      end
    end
  end
end
