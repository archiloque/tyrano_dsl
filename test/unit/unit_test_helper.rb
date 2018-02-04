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
            image_path
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
        stances
    )
  end

  # @param [TyranoDsl::Elements::World] world
  # @param [String] variable_name
  # @param [Float\String|nil] initial_value
  def declare_variable(world, variable_name, initial_value = nil)
    world.variables[variable_name] = TyranoDsl::Elements::Variable.new(
        variable_name,
        initial_value
    )
  end

  # @param [TyranoDsl::Elements::World] world
  # @param [String] scene_name
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def declare_scene(world, scene_name)
    world.scenes[scene_name] = TyranoDsl::Elements::Scene.new(
        scene_name
    )
  end

  # @param [TyranoDsl::Elements::World] world
  # @param [String] scene_name
  # @param [String] label_name
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def declare_label(world, scene_name, label_name)
    world.scenes[scene_name].labels << label_name
  end

  # @param [TyranoDsl::Elements::World] world
  # @param [String] scene_name
  # @param [String|nil] label_name
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def declare_jump_target(world, scene_name, label_name = nil)
    world.jump_targets << TyranoDsl::Elements::JumpTarget.new(scene_name, label_name, [])
  end

  # @param [String] expected_message
  # @return [void]
  def assert_tyrano_exception(expected_message)
    begin
      yield
      fail
    rescue TyranoDsl::TyranoException => e
      assert_equal(expected_message, e.message)
    end
  end

end
