require_relative 'words_base_test'
require_relative '../../../../lib/tyrano_dsl/export_tyrano/words/conditional_jump'

class ExportTyranoWords::ConditionalJumpTest < ExportTyranoWords::WordsBaseTest

  def setup
    super
    @conditional_jump = TyranoDsl::ExportTyrano::Words::ConditionalJump.new
  end

  def test_ok_no_label
    @context.init_new_scene 'scene'
    declare_scene(@world, 'scene name')
    declare_variable(@world, 'a', 10)
    declare_variable(@world, 'b', 10)
    @context.after_setup
    @conditional_jump.run(@context, @world, variable: 'a', operator: '<', value: 'b', scene_name: 'scene name', label_name: nil)
    assert_equal(['[jump storage="scene1.ks" target="cond" cond="f.variable_1<f.variable_2"]'], @context.current_scene_content)
  end

  def test_ok_variable_inferior
    @context.init_new_scene 'scene'
    declare_scene(@world, 'scene name')
    declare_label(@world, 'scene name', 'label name')
    declare_variable(@world, 'a', 10)
    declare_variable(@world, 'b', 10)
    @context.after_setup
    @conditional_jump.run(@context, @world, variable: 'a', operator: '<', value: 'b', scene_name: 'scene name', label_name: 'label name')
    assert_equal(['[jump storage="scene1.ks" target="label_0" cond="f.variable_1<f.variable_2"]'], @context.current_scene_content)
  end

  def test_ok_variable_superior
    @context.init_new_scene 'scene'
    declare_scene(@world, 'scene name')
    declare_label(@world, 'scene name', 'label name')
    declare_variable(@world, 'a', 10)
    declare_variable(@world, 'b', 10)
    @context.after_setup
    @conditional_jump.run(@context, @world, variable: 'a', operator: '>', value: 'b', scene_name: 'scene name', label_name: 'label name')
    assert_equal(['[jump storage="scene1.ks" target="label_0" cond="f.variable_1>f.variable_2"]'], @context.current_scene_content)
  end

  def test_ok_variable_equal
    @context.init_new_scene 'scene'
    declare_scene(@world, 'scene name')
    declare_label(@world, 'scene name', 'label name')
    declare_variable(@world, 'a', 10)
    declare_variable(@world, 'b', 10)
    @context.after_setup
    @conditional_jump.run(@context, @world, variable: 'a', operator: '==', value: 'b', scene_name: 'scene name', label_name: 'label name')
    assert_equal(['[jump storage="scene1.ks" target="label_0" cond="f.variable_1=f.variable_2"]'], @context.current_scene_content)
  end

  def test_ok_variable_different
    @context.init_new_scene 'scene'
    declare_scene(@world, 'scene name')
    declare_label(@world, 'scene name', 'label name')
    declare_variable(@world, 'a', 10)
    declare_variable(@world, 'b', 10)
    @context.after_setup
    @conditional_jump.run(@context, @world, variable: 'a', operator: '!=', value: 'b', scene_name: 'scene name', label_name: 'label name')
    assert_equal(['[jump storage="scene1.ks" target="label_0" cond="f.variable_1<>f.variable_2"]'], @context.current_scene_content)
  end

  def test_ok_value
    @context.init_new_scene 'scene'
    declare_scene(@world, 'scene name')
    declare_label(@world, 'scene name', 'label name')
    declare_variable(@world, 'a', 10)
    @context.after_setup
    @conditional_jump.run(@context, @world, variable: 'a', operator: '>', value: 10, scene_name: 'scene name', label_name: 'label name')
    assert_equal(['[jump storage="scene1.ks" target="label_0" cond="f.variable_1>10"]'], @context.current_scene_content)
  end

end
