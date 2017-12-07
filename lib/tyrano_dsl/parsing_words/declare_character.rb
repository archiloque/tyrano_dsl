require_relative '../elements/character'
require_relative '../vocabulary'
require_relative 'parsing_words_module'

module TyranoDsl
  module ParsingWords

    module DeclareCharacter

      include TyranoDsl::ParsingWords::ParsingWordsModule

      # @param [String] character_name
      # @param [Hash{String => String}] stances
      # @return [void]
      def declare_character(character_name, stances)
        stances.values.each do |path|
          validate_image_exist(
              path
          )
        end
        if context.world.characters.key? character_name
          raise ::TyranoDsl::TyranoException, "Line #{word_location.lineno} duplicated character [#{character_name}]"
        end
        context.world.characters[character_name] = TyranoDsl::Elements::Character.new(
            character_name,
            stances,
            context.world.characters.length + 1
        )

        add_parsed_word(
            TyranoDsl::Vocabulary::DECLARE_CHARACTER,
            name: character_name, stances: stances
        )
      end
    end
  end
end
