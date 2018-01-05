require_relative 'eg_writing_words_helper'
require_relative '../../../../lib/tyrano_dsl/export_game/writing_words/show_message_window'

class EGWritingWordsShowMessageWindowTest < Minitest::Test

  include EGWritingWordsHelper

  def test_no_current_scene
    world = create_world
    writing_context = create_writing_context(world)
    show_message_window = TyranoDsl::ExportGame::WritingWords::ShowMessageWindow.new
    assert_tyrano_exception('This action should take place in a scene') do
      show_message_window.run(writing_context, world, caller, {})
    end
  end

  def test_ok
    world = create_world
    writing_context = create_writing_context(world)
    writing_context.init_new_scene 'scene'
    show_message_window = TyranoDsl::ExportGame::WritingWords::ShowMessageWindow.new
    show_message_window.run(writing_context, world, caller, {})
    assert_equal(['[tb_show_message_window]'], writing_context.current_scene_content)
  end

end
