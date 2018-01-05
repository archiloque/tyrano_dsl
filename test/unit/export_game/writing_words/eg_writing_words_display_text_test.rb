require_relative 'eg_writing_words_helper'
require_relative '../../../../lib/tyrano_dsl/export_game/writing_words/display_text'

class EGWritingWordsDisplayTextTest < Minitest::Test

  include EGWritingWordsHelper

  def test_no_current_scene
    world = create_world
    writing_context = create_writing_context(world)
    declare_scene(world, 'scene name')
    declare_character(world, 'character name', {})
    display_text = TyranoDsl::ExportGame::WritingWords::DisplayText.new
    assert_tyrano_exception('This action should take place in a scene') do
      display_text.run(writing_context, world, caller, character_name: 'character name', text: 'blah')
    end
  end

  def test_ok_with_character
    world = create_world
    writing_context = create_writing_context(world)
    writing_context.init_new_scene 'scene'
    declare_character(world, 'character name', {})
    display_text = TyranoDsl::ExportGame::WritingWords::DisplayText.new
    display_text.run(writing_context, world, caller, character_name: 'character name', text: 'blah')
    assert_equal([
                     '[tb_start_text mode=1]
#character name
blah
[_tb_end_text]
'], writing_context.current_scene_content)
  end

  def test_ok_without_character
    world = create_world
    writing_context = create_writing_context(world)
    writing_context.init_new_scene 'scene'
    display_text = TyranoDsl::ExportGame::WritingWords::DisplayText.new
    display_text.run(writing_context, world, caller, character_name: nil, text: 'blah')
    assert_equal(['[tb_start_text mode=1]
blah
[_tb_end_text]
'], writing_context.current_scene_content)
  end


end
