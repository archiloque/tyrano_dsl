require_relative 'parsing_words_module'
require_relative '../vocabulary'
require_relative '../elements/scene'

module TyranoDsl
  module ParsingWords

    # @!macro word_start_scene
    module StartScene

      include TyranoDsl::ParsingWords::ParsingWordsModule

      # @param [String] scene_name
      # @return [void]
      def start_scene(scene_name)
        if context.world.scenes.key? scene_name
          raise ::TyranoDsl::TyranoException, "Line #{word_location.lineno} duplicated scene [#{scene_name}]"
        end
        context.world.scenes[scene_name] =
            TyranoDsl::Elements::Scene.new(
                scene_name,
                context.world.scenes.length + 1
            )
        add_parsed_word(
            TyranoDsl::Vocabulary::START_SCENE,
            name: scene_name
        )
      end
    end
  end
end
