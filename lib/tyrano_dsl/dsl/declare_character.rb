require_relative 'dsl_module'
require_relative '../vocabulary'
require_relative '../elements/character'

module TyranoDsl
  module Dsl

    # @!macro word_declare_character
    module DeclareCharacter

      include TyranoDsl::Dsl::DslModule

      # @param [String] character_name
      # @param [String] images_dir
      # @param [Hash{String => String}] stances
      # @return [void]
      def declare_character(character_name, images_dir, stances)
        stances.values.each do |path|
          validate_image_exist(
              File.join(images_dir, path)
          )
        end
        if context.world.characters.key? character_name
          raise ::TyranoDsl::TyranoException, "Line #{word_location.lineno} duplicated character [#{character_name}]"
        end
        context.world.characters[character_name] = TyranoDsl::Elements::Character.new(character_name, images_dir, stances)

        add_parsed_word(
            TyranoDsl::Vocabulary::DECLARE_CHARACTER,
            name: character_name, images_dir: images_dir, stances: stances
        )
      end
    end
  end
end
