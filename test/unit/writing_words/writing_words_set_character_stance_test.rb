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
    assert_tyrano_exception('This action should take place in a scene') do
      set_character_stance.run(writing_context, world, caller, name: 'character name', stance: :default)
    end
  end

  def test_ok
    world = create_world
    writing_context = create_writing_context(world)
    writing_context.init_new_scene 'scene'
    declare_scene(world, 'scene name')
    declare_character(world, 'character name', :default => 'default.png')
    set_character_stance = TyranoDsl::WritingWords::SetCharacterStance.new
    set_character_stance.run(writing_context, world, caller, name: 'character name', stance: :default)
    assert_equal([
                     '[chara_mod name="character name" cross="true" storage="chara/1/0.png"]'
                 ], writing_context.current_scene_content)
    assert_equal(1, writing_context.current_scene_assets.length)
    assert_equal('data/fgimage/chara/1/0.png', writing_context.current_scene_assets.to_a[0])
  end

end
