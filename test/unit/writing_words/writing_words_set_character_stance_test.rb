require_relative 'writing_words_helper'
require_relative '../../../lib/tyrano_dsl/writing_words/set_character_stance'

class WritingWordsSetCharacterStanceTest < Minitest::Test

  include WritingWordsHelper

  def test_no_current_scene
    world = create_world
    writing_context = create_writing_context(world)
    declare_scene(world, 'scene name')
    declare_character(world, 'character name', :default => 'default.png')
    set_character_stance = TyranoDsl::WritingWords::SetCharacterStance.new
    begin
      set_character_stance.run(writing_context, world, caller_locations, name: 'character name', stance: :default)
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match(/Line \d+ this action should take place in a scene/, e.message)
    end
  end

  def test_ok
    world = create_world
    writing_context = create_writing_context(world)
    writing_context.init_new_scene 'scene'
    declare_scene(world, 'scene name')
    declare_character(world, 'character name', :default => 'default.png')
    set_character_stance = TyranoDsl::WritingWords::SetCharacterStance.new
    set_character_stance.run(writing_context, world, caller_locations, name: 'character name', stance: :default)
    assert_equal(writing_context.current_scene_content, [
        '[chara_mod name="character name" cross="true" storage="1/0.png"]'
    ])
    assert_equal(writing_context.current_scene_assets.length, 1)
    assert_equal(writing_context.current_scene_assets.to_a[0], 'data/fgimage/chara/1/0.png')
  end

end
