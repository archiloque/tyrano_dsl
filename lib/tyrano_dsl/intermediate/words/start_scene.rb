require_relative '../../elements/scene'
require_relative 'empty_word'

class TyranoDsl::Intermediate::Words::StartScene < TyranoDsl::Intermediate::Words::EmptyWord

  # @param [TyranoDsl::Intermediate::Context] context
  # @param [TyranoDsl::Elements::World] world
  # @param [Array<String>] word_location
  # @param [Hash{Symbol=>Object}] parameters
  # @option parameters [String] :scene_name
  # @return [void]
  def world_construction_phase(context, world, word_location, parameters)
    scene_name = parameters[:scene_name]
    if world.scenes.key? scene_name
      TyranoDsl::TyranoException.raise_exception "Duplicated scene [#{scene_name}]", word_location
    end
    unless world.title_screen.first_scene_name
      world.title_screen.first_scene_name = scene_name
    end
    world.scenes[scene_name] =
        TyranoDsl::Elements::Scene.new(
            scene_name
        )
    context.current_scene = world.scenes[parameters[:scene_name]]
  end

end