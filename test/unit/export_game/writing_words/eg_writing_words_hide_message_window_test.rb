require_relative 'eg_writing_words_helper'
require_relative '../../../../lib/tyrano_dsl/export_game/writing_words//hide_message_window'

class EGWritingWordsHideMessageWindowTest < Minitest::Test

  include EGWritingWordsHelper

  def test_no_current_scene
    world = create_world
    writing_context = create_writing_context(world)
    hide_message_window = TyranoDsl::ExportGame::WritingWords::HideMessageWindow.new
    assert_tyrano_exception('This action should take place in a scene') do
      hide_message_window.run(writing_context, world, caller, {})
    end
  end

  def test_ok
    world = create_world
    writing_context = create_writing_context(world)
    writing_context.init_new_scene 'scene'
    hide_message_window = TyranoDsl::ExportGame::WritingWords::HideMessageWindow.new
    hide_message_window.run(writing_context, world, caller, {})
    assert_equal(['[tb_hide_message_window]'], writing_context.current_scene_content)
  end

end
