require_relative '../../test_helper'
require_relative '../../../lib/tyrano_dsl/elements/jump_target'
require_relative '../../../lib/tyrano_dsl/elements/scene'
require_relative '../../../lib/tyrano_dsl/elements/world'

class WorldTest < Minitest::Test

  def test_validate_unknown_scene_in_jump
    world = TyranoDsl::Elements::World.new(__FILE__)
    world.jump_targets << TyranoDsl::Elements::JumpTarget.new('missing scene', nil)
    begin
      world.validate
      fail
    rescue TyranoDsl::TyranoException => e
      assert_equal 'Unknown scene [missing scene] declared in label', e.message
    end
  end

  def test_validate_unknown_label_in_jump
    world = TyranoDsl::Elements::World.new(__FILE__)
    world.jump_targets << TyranoDsl::Elements::JumpTarget.new('scene name', world.label_value('missing label'))
    world.scenes['scene name'] = TyranoDsl::Elements::Scene.new('scene name', 1)
    begin
      world.validate
      fail
    rescue TyranoDsl::TyranoException => e
      assert_equal 'Unknown label [missing label] declared in label', e.message
    end
  end

  def test_validate_ok
    world = TyranoDsl::Elements::World.new(__FILE__)
    world.jump_targets << TyranoDsl::Elements::JumpTarget.new('scene without label', world.label_value(nil))
    world.jump_targets << TyranoDsl::Elements::JumpTarget.new('scene with label', world.label_value('label name'))
    scene_with_label = TyranoDsl::Elements::Scene.new('scene with label', 1)
    scene_with_label.labels << 'label name'
    world.scenes['scene with label'] = scene_with_label
    world.scenes['scene without label'] = TyranoDsl::Elements::Scene.new('scene without label', 1)
    world.validate
  end

  def test_same_labels
    world = TyranoDsl::Elements::World.new(__FILE__)
    label1 = world.label_value('label')
    label2 = world.label_value('label')
    assert_equal label1, label2
    assert_equal label1.technical_name, label2.technical_name
  end

end