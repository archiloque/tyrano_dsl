require_relative 'words_base_test'
require_relative '../../../../lib/tyrano_dsl/export_tyrano/words/jump'

class ExportTyranoWords::JumpTest < ExportTyranoWords::WordsBaseTest

  def setup
    super
    @jump = TyranoDsl::ExportTyrano::Words::Jump.new
  end

  def test_ok_with_label
    @context.init_new_scene 'scene'
    declare_scene(@world, 'scene name')
    declare_label(@world, 'scene name', 'label name')
    @jump.run(@context, @world, scene_name: 'scene name', label_name: 'label name')
    assert_equal(['[jump storage="scene1.ks" target="label_0"]'], @context.current_scene_content)
  end

  def test_ok_no_label
    @context.init_new_scene 'scene'
    declare_scene(@world, 'scene name')
    @jump.run(@context, @world, scene_name: 'scene name', label_name: nil)
    assert_equal(['[jump storage="scene1.ks" target=""]'], @context.current_scene_content)
  end
end
