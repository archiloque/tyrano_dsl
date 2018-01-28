require_relative '../../../../lib/tyrano_dsl/validation/words/jump'
require_relative 'words_base_test'

class ValidationWords::JumpTest < ValidationWords::WordsBaseTest

  def setup
    super
    @jump = TyranoDsl::Validation::Words::Jump.new
  end

  def test_ok_value
    @jump.world_construction_phase(
        @context,
        @world,
        caller,
        scene_name: 'target scene',
        label_name: 'target_label'
    )
    assert_equal(1, @world.jump_targets.length)
    jump_target = @world.jump_targets.first
    assert_equal('target scene', jump_target.scene)
    assert_equal('target_label', jump_target.label)
  end

  def test_ok_without_scene
    @jump.world_construction_phase(
        @context,
        @world,
        caller,
        scene_name: 'target scene',
        )
    assert_equal(1, @world.jump_targets.length)
    jump_target = @world.jump_targets.first
    assert_equal('target scene', jump_target.scene)
  end

end
