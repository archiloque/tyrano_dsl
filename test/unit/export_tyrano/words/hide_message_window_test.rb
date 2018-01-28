require_relative 'words_base_test'
require_relative '../../../../lib/tyrano_dsl/export_tyrano/words//hide_message_window'

class ExportTyranoWords::HideMessageWindowTest < ExportTyranoWords::WordsBaseTest

  def setup
    super
    @hide_message_window = TyranoDsl::ExportTyrano::Words::HideMessageWindow.new
  end

  def test_ok
    @context.init_new_scene 'scene'
    @hide_message_window.run(@context, @world, {})
    assert_equal(['[tb_hide_message_window]'], @context.current_scene_content)
  end

end
