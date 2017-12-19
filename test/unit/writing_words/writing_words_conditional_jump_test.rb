require_relative 'writing_words_helper'
require_relative '../../../lib/tyrano_dsl/writing_words/conditional_jump'

class WritingWordsConditionalJumpTest < Minitest::Test

  include WritingWordsHelper

  def test_no_current_scene
    world = create_world
    writing_context = create_writing_context(world)
    declare_scene(world, 'scene name')
    declare_label(world, 'label name')
    declare_variable(world, 'a', 10)
    conditional_jump = TyranoDsl::WritingWords::ConditionalJump.new
    begin
      conditional_jump.run(writing_context, world, caller_locations, variable: 'a', operator: '>', value: 10, scene_name: 'scene name', label_name: 'label name')
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match(/Line \d+ this action should take place in a scene/, e.message)
    end
  end

  def test_unknown_scene
    world = create_world
    writing_context = create_writing_context(world)
    writing_context.init_new_scene 'scene'
    declare_label(world, 'label name')
    declare_variable(world, 'a', 10)
    conditional_jump = TyranoDsl::WritingWords::ConditionalJump.new
    begin
      conditional_jump.run(writing_context, world, caller_locations, variable: 'a', operator: '>', value: 10, scene_name: 'scene name', label_name: 'label name')
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match(/Line \d+ unknown scene \[scene name\], currently defined: /, e.message)
    end
  end

  def test_ok_variable
    world = create_world
    writing_context = create_writing_context(world)
    writing_context.init_new_scene 'scene'
    declare_scene(world, 'scene name')
    declare_label(world, 'label name')
    declare_variable(world, 'a', 10)
    declare_variable(world, 'b', 10)
    conditional_jump = TyranoDsl::WritingWords::ConditionalJump.new
    conditional_jump.run(writing_context, world, caller_locations, variable: 'a', operator: '>', value: 'b', scene_name: 'scene name', label_name: 'label name')
    assert_equal(writing_context.current_scene_content, ['[jump storage="scene1.ks" target="label_0" cond="f.variable_1>f.variable_2"]'])
  end

  def test_ok_value
    world = create_world
    writing_context = create_writing_context(world)
    writing_context.init_new_scene 'scene'
    declare_scene(world, 'scene name')
    declare_label(world, 'label name')
    declare_variable(world, 'a', 10)
    conditional_jump = TyranoDsl::WritingWords::ConditionalJump.new
    conditional_jump.run(writing_context, world, caller_locations, variable: 'a', operator: '>', value: 10, scene_name: 'scene name', label_name: 'label name')
    assert_equal(writing_context.current_scene_content, ['[jump storage="scene1.ks" target="label_0" cond="f.variable_1>10"]'])
  end

end
