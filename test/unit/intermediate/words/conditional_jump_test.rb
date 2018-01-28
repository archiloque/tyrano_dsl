require_relative '../../../../lib/tyrano_dsl/intermediate/words/conditional_jump'
require_relative 'words_base_test'

class IntermediateWords::ConditionalJumpTest < IntermediateWords::WordsBaseTest

  def setup
    super
    @conditional_jump = TyranoDsl::Intermediate::Words::ConditionalJump.new
  end

  def test_ok_variable
    @conditional_jump.world_construction_phase(
        @context,
        @world,
        caller,
        variable: 'a',
        operator: '<',
        value: 'b',
        scene_name: 'target scene',
        label_name: 'target_label'

    )
    assert_equal(1, @world.jump_targets.length)
    jump_target = @world.jump_targets.first
    assert_equal('target scene', jump_target.scene)
    assert_equal('target_label', jump_target.label)
    declare_variable(@world, 'a', 5)
    declare_variable(@world, 'b', 10)

    @conditional_jump.validation_phase(
        @context,
        @world,
        caller,
        variable: 'a',
        operator: '<',
        value: 'b',
        scene_name: 'target scene',
        label_name: 'target_label'
    )
  end

  def test_ok_value
    @conditional_jump = TyranoDsl::Intermediate::Words::ConditionalJump.new
    @conditional_jump.world_construction_phase(
        @context,
        @world,
        caller,
        variable: 'a',
        operator: '<',
        value: 5,
        scene_name: 'target scene',
        label_name: 'target_label'

    )
    assert_equal(1, @world.jump_targets.length)
    jump_target = @world.jump_targets.first
    assert_equal('target scene', jump_target.scene)
    assert_equal('target_label', jump_target.label)
    declare_variable(@world, 'a', 5)
    @conditional_jump.validation_phase(
        @context,
        @world,
        caller,
        variable: 'a',
        operator: '<',
        value: 5,
        scene_name: 'target scene',
        label_name: 'target_label'
    )
  end

  def test_ok_without_scene
    @conditional_jump = TyranoDsl::Intermediate::Words::ConditionalJump.new
    @conditional_jump.world_construction_phase(
        @context,
        @world,
        caller,
        variable: 'a',
        operator: '<',
        value: 5,
        scene_name: 'target scene'

    )
    assert_equal(1, @world.jump_targets.length)
    jump_target = @world.jump_targets.first
    assert_equal('target scene', jump_target.scene)
    declare_variable(@world, 'a', 5)
    @conditional_jump.validation_phase(
        @context,
        @world,
        caller,
        variable: 'a',
        operator: '<',
        value: 5,
        scene_name: 'target scene'
    )
  end

  def test_unknown_variable
    @conditional_jump = TyranoDsl::Intermediate::Words::ConditionalJump.new
    assert_tyrano_exception('Unknown variable [a]') do
      @conditional_jump.validation_phase(
          @context,
          @world,
          caller,
          variable: 'a',
          operator: '<',
          value: 5,
          scene_name: 'target scene'
      )
    end
  end

  def test_unknown_operator
    @conditional_jump = TyranoDsl::Intermediate::Words::ConditionalJump.new
    declare_variable(@world, 'a', 10)
    assert_tyrano_exception('Unknown operator [?]') do
      @conditional_jump.validation_phase(
          @context,
          @world,
          caller,
          variable: 'a',
          operator: '?',
          value: 5,
          scene_name: 'target scene'
      )
    end
  end

  def test_unknown_value_variable
    @conditional_jump = TyranoDsl::Intermediate::Words::ConditionalJump.new
    declare_variable(@world, 'a', 10)
    assert_tyrano_exception('Unknown variable [b]') do
      @conditional_jump.validation_phase(
          @context,
          @world,
          caller,
          variable: 'a',
          operator: '<',
          value: 'b',
          scene_name: 'target scene'
      )
    end
  end


end
