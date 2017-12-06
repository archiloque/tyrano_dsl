require_relative 'words_module'
require_relative '../vocabulary'
require_relative '../elements/scene'

module TyranoDsl
  module Words

    # @!macro word_start_scene
    module StartScene

      include TyranoDsl::Words::WordsModule

      # @!macro word_parse
      def start_scene(scene_name)
        if context.world.scenes.key? scene_name
          raise ::TyranoDsl::TyranoException, "Line #{word_location.lineno} duplicated scene [#{scene_name}]"
        end
        context.world.scenes[scene_name] =
            TyranoDsl::Elements::Scene.new(
                scene_name,
                context.world.scenes.length + 1
            )
        context.add_word(
            TyranoDsl::Vocabulary::START_SCENE,
            word_location,
            name: scene_name
        )
      end
    end
  end
end
