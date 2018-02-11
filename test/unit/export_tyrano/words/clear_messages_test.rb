require_relative 'words_base_test'
require_relative '../../../../lib/tyrano_dsl/export_tyrano/words/clear_messages'

class ExportTyranoWords::ClearMessagesTest < ExportTyranoWords::WordsBaseTest

  def setup
    super
    @clear_messages = TyranoDsl::ExportTyrano::Words::ClearMessages.new
  end

  def test_ok
    @context.init_new_scene 'scene'
    @clear_messages.run(@context, @world, {})
    assert_equal(['[cm]'], @context.current_scene_content)
  end

end
