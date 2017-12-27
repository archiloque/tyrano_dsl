require_relative 'parsing_words_module'
require_relative '../vocabulary'
require_relative '../elements/scene'

module TyranoDsl::ParsingWords::StartScene

  include TyranoDsl::ParsingWords::ParsingWordsModule

  # @param [String] scene_name
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def start_scene(scene_name)
    if context.world.scenes.key? scene_name
      raise TyranoDsl::TyranoException, "Duplicated scene [#{scene_name}]"
    end
    unless context.world.title_screen.first_scene_name
      context.world.title_screen.first_scene_name = scene_name
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
