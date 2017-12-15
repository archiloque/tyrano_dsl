require_relative 'writing_words_helper'
require_relative '../../../lib/tyrano_dsl/parser'
require_relative '../../../lib/tyrano_dsl/writing_words/show_message_window'

class ShowMessageWindowTest < Minitest::Test

  include WritingWordsHelper

  def test_no_current_scene
    world = create_world
    writing_context = create_writing_context(world)
    show_message_window = TyranoDsl::WritingWords::ShowMessageWindow.new
    begin
      show_message_window.run(writing_context, world, caller_locations, {})
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match /Line \d+ this action should take place in a scene/, e.message
    end
  end

  def test_ok
    world = create_world
    writing_context = create_writing_context(world)
    writing_context.init_new_scene 'scene'
    show_message_window = TyranoDsl::WritingWords::ShowMessageWindow.new
    show_message_window.run(writing_context, world, caller_locations, {})
    assert_equal writing_context.current_scene_content, ['[tb_show_message_window]']
  end

end
