require_relative 'elements_helper'
require_relative '../../../lib/tyrano_dsl/elements/jump_target'
require_relative '../../../lib/tyrano_dsl/elements/scene'
require_relative '../../../lib/tyrano_dsl/elements/world'

class ElementsWorldTest < Minitest::Test

  include ElementsHelper

  def test_validate_unknown_scene_in_jump
    world = TyranoDsl::Elements::World.new
    declare_jump_target(world, 'missing scene')
    assert_tyrano_exception('Unknown scene [missing scene] declared in label') do
      world.validate
    end
  end

  def test_validate_unknown_label_in_jump
    world = TyranoDsl::Elements::World.new
    declare_jump_target(world, 'scene name', 'missing label')
    world.scenes['scene name'] = TyranoDsl::Elements::Scene.new('scene name')
    assert_tyrano_exception('Unknown label [missing label] declared in label') do
      world.validate
    end
  end

  def test_validate_ok
    world = TyranoDsl::Elements::World.new
    declare_jump_target(world, 'scene without label')
    declare_jump_target(world, 'scene with label', 'label name')
    scene_with_label = TyranoDsl::Elements::Scene.new('scene with label')
    scene_with_label.labels << 'label name'
    world.scenes['scene with label'] = scene_with_label
    world.scenes['scene without label'] = TyranoDsl::Elements::Scene.new('scene without label')
    world.validate
  end

end