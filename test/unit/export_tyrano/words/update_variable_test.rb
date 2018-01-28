require_relative 'words_base_test'
require_relative '../../../../lib/tyrano_dsl/export_tyrano/words/update_variable'

class ExportTyranoWords::UpdateVariableTest < ExportTyranoWords::WordsBaseTest

  def setup
    super
    @update_variable = TyranoDsl::ExportTyrano::Words::UpdateVariable.new
  end

  def test_ok_variable
    @context.init_new_scene 'scene'
    declare_variable(@world, 'a', 10)
    declare_variable(@world, 'b', 10)
    @update_variable.run(@context, @world, variable: 'a', operator: '=', value: 'b')
    assert_equal(['[tb_eval  exp="f.variable_1=f.variable_2"  name="variable_1"  cmd="="  op="h"  val="variable_2"  val_2="undefined"]'], @context.current_scene_content)
  end

  def test_ok_value
    @context.init_new_scene 'scene'
    declare_variable(@world, 'a', 10)
    @update_variable.run(@context, @world, variable: 'a', operator: '+=', value: 10)
    assert_equal(['[tb_eval  exp="f.variable_1+=10"  name="variable_1"  cmd="+="  op="t"  val="10"  val_2="undefined"]'], @context.current_scene_content)
  end

end
