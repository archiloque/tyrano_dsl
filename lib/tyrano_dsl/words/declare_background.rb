require_relative '../elements/background'
require_relative '../vocabulary'
require_relative 'words_module'

module TyranoDsl
  module Words

    # @!macro word_declare_background
    class DeclareBackground

      include TyranoDsl::Words::WordsModule

      # @!macro word_parse
      def parse(context, word_location, parameters)
        validate_parameters_length(
            word_location,
            [
                'the background name',
                'the path to the background image',
            ],
            parameters)
        background_name = parameters[0]
        image_path = parameters[1]
        validate_image_exist(
            word_location,
            File.join(context.base_path, image_path)
        )
        if context.world.backgrounds.key? background_name
          raise ::TyranoDsl::TyranoException, "Line #{word_location.lineno} duplicated background [#{background_name}]"
        end
        context.world.backgrounds[background_name] =
            TyranoDsl::Elements::Background.new(
                background_name,
                image_path,
                context.world.backgrounds.length + 1
            )
        context.add_word(
            TyranoDsl::Vocabulary::DECLARE_BACKGROUND,
            word_location,
            name: background_name, image_path: image_path
        )
      end
    end
  end
end
