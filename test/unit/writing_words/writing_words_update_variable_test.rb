require_relative 'writing_words_helper'
require_relative '../../../lib/tyrano_dsl/writing_words/update_variable'

class WritingWordsUpdateVariableTest < Minitest::Test

  include WritingWordsHelper

  def test_no_current_scene
    world = create_world
    writing_context = create_writing_context(world)
    declare_variable(world, 'a', 10)
    update_variable = TyranoDsl::WritingWords::UpdateVariable.new
    assert_tyrano_exception('This action should take place in a scene') do
      update_variable.run(writing_context, world, caller, variable: 'a', operator: '=', value: 10)
    end
  end

  def test_ok_variable
    world = create_world
    writing_context = create_writing_context(world)
    writing_context.init_new_scene 'scene'
    declare_variable(world, 'a', 10)
    declare_variable(world, 'b', 10)
    update_variable = TyranoDsl::WritingWords::UpdateVariable.new
    update_variable.run(writing_context, world, caller, variable: 'a', operator: '=', value: 'b')
    assert_equal(['[tb_eval  exp="f.variable_1=f.variable_2"  name="variable_1"  cmd="="  op="h"  val="variable_2"  val_2="undefined"]'], writing_context.current_scene_content)
  end

  def test_ok_value
    world = create_world
    writing_context = create_writing_context(world)
    writing_context.init_new_scene 'scene'
    declare_variable(world, 'a', 10)
    update_variable = TyranoDsl::WritingWords::UpdateVariable.new
    update_variable.run(writing_context, world, caller, variable: 'a', operator: '+=', value: 10)
    assert_equal(['[tb_eval  exp="f.variable_1+=10"  name="variable_1"  cmd="+="  op="t"  val="10"  val_2="undefined"]'], writing_context.current_scene_content)
  end

end
