require_relative 'writing_words_helper'
require_relative '../../../lib/tyrano_dsl/parser'
require_relative '../../../lib/tyrano_dsl/writing_words/display_text'

class DisplayTextTest < Minitest::Test

  include WritingWordsHelper

  def test_no_current_scene
    world = create_world
    writing_context = create_writing_context(world)
    declare_scene(world, 'scene name')
    declare_character(world, 'character name', {})
    display_text = TyranoDsl::WritingWords::DisplayText.new
    begin
      display_text.run(writing_context, world, caller_locations, {character_name: 'character name', text: 'blah'})
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match(/Line \d+ this action should take place in a scene/, e.message)
    end
  end

  def test_ok_with_character
    world = create_world
    writing_context = create_writing_context(world)
    writing_context.init_new_scene 'scene'
    declare_character(world, 'character name', {})
    display_text = TyranoDsl::WritingWords::DisplayText.new
    display_text.run(writing_context, world, caller_locations, {character_name: 'character name', text: 'blah'})
    assert_equal(writing_context.current_scene_content, [
        '[tb_start_text mode=1]
#character name
blah
[_tb_end_text]
'])
  end

  def test_ok_without_character
    world = create_world
    writing_context = create_writing_context(world)
    writing_context.init_new_scene 'scene'
    display_text = TyranoDsl::WritingWords::DisplayText.new
    display_text.run(writing_context, world, caller_locations, {character_name: nil, text: 'blah'})
    assert_equal(writing_context.current_scene_content, ['[tb_start_text mode=1]
blah
[_tb_end_text]
'])
  end


end
