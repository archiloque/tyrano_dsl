require_relative '../elements/background'
require_relative '../vocabulary'
require_relative 'parsing_words_module'

module TyranoDsl
  module ParsingWords

    # @!macro word_declare_background
    module DeclareBackground

      include TyranoDsl::ParsingWords::ParsingWordsModule

      # @param [String] background_name
      # @param [String] image_path
      # @return [void]
      def declare_background(background_name, image_path)
        validate_image_exist(image_path)
        if context.world.backgrounds.key? background_name
          raise ::TyranoDsl::TyranoException, "Line #{word_location.lineno} duplicated background [#{background_name}]"
        end
        context.world.backgrounds[background_name] =
            TyranoDsl::Elements::Background.new(
                background_name,
                image_path,
                context.world.backgrounds.length + 1
            )
        add_parsed_word(
            TyranoDsl::Vocabulary::DECLARE_BACKGROUND,
            name: background_name, image_path: image_path
        )
      end
    end
  end
end
