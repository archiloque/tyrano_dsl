require_relative '../test_helper'

module UnitTestHelper

  protected

  # @param [TyranoDsl::Elements::World] world
  # @param [String] background_name
  # @param [String] image_path
  def declare_background(world, background_name, image_path)
    world.backgrounds[background_name] =
        TyranoDsl::Elements::Background.new(
            background_name,
            image_path,
            world.backgrounds.length + 1
        )
  end

  # @param [TyranoDsl::Elements::World] world
  # @param [String] character_name
  # @param [Hash{String => String}] stances
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def declare_character(world, character_name, stances)
    world.characters[character_name] = TyranoDsl::Elements::Character.new(
        character_name,
        stances,
        world.characters.length + 1
    )

  end

  # @param [TyranoDsl::Elements::World] world
  # @param [String] scene_name
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def declare_scene(world, scene_name)
    world.scenes[scene_name] = TyranoDsl::Elements::Scene.new(
        scene_name,
        world.characters.length + 1
    )
  end

  # @param [TyranoDsl::Elements::World] world
  # @param [String] label_name
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def declare_label(world, label_name)
    world.label_value(label_name)
  end

  # @param [TyranoDsl::Elements::World] world
  # @param [String] scene_name
  # @param [String|nil] label_name
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def declare_jump_target(world, scene_name, label_name = nil)
    world.jump_targets << TyranoDsl::Elements::JumpTarget.new(scene_name, label_name ? world.label_value(label_name) : nil)
  end


end
