require_relative 'writing_words_helper'
require_relative '../../../lib/tyrano_dsl/parser'
require_relative '../../../lib/tyrano_dsl/writing_words/hide_character'

class HideCharacterTest < Minitest::Test

  include WritingWordsHelper

  def test_no_current_scene
    world = create_world
    writing_context = create_writing_context(world)
    world.scenes['scene name'] = TyranoDsl::Elements::Scene.new('scene name', 0)
    world.characters['character name'] = TyranoDsl::Elements::Character.new('character name', {}, 0)
    hide_character = TyranoDsl::WritingWords::HideCharacter.new
    begin
      hide_character.run(writing_context, world, caller_locations, {name: 'character name'})
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match /Line \d+ this action should take place in a scene/, e.message
    end
  end

  def test_ok
    world = create_world
    writing_context = create_writing_context(world)
    writing_context.init_new_scene 'scene'
    world.characters['character name'] = TyranoDsl::Elements::Character.new('character name', {}, 0)
    hide_character = TyranoDsl::WritingWords::HideCharacter.new
    hide_character.run(writing_context, world, caller_locations, {name: 'character name'})
    assert_equal writing_context.current_scene_content, ['[chara_hide name="character name" time="1000" wait="true"]']
  end

end
