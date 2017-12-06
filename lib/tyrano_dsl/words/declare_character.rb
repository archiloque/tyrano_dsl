require_relative 'words_module'
require_relative '../vocabulary'
require_relative '../elements/character'

module TyranoDsl
  module Words

    # @!macro word_declare_character
    module DeclareCharacter

      include TyranoDsl::Words::WordsModule

      def declare_character(character_name, images_dir, stances)
        stances.values.each do |path|
          validate_image_exist(
              File.join(context.base_path, images_dir, path)
          )
        end
        if context.world.characters.key? character_name
          raise ::TyranoDsl::TyranoException, "Line #{word_location.lineno} duplicated character [#{character_name}]"
        end
        context.world.characters[character_name] = TyranoDsl::Elements::Character.new(character_name, images_dir, stances)

        context.add_word(
            TyranoDsl::Vocabulary::DECLARE_CHARACTER,
            word_location,
            name: character_name, images_dir: images_dir, stances: stances
        )
      end
    end
  end
end