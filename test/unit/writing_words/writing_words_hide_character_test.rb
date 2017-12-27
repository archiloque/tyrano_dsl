require_relative 'writing_words_helper'
require_relative '../../../lib/tyrano_dsl/writing_words/hide_character'

class WritingWordsHideCharacterTest < Minitest::Test

  include WritingWordsHelper

  def test_no_current_scene
    world = create_world
    writing_context = create_writing_context(world)
    declare_scene(world, 'scene name')
    declare_character(world, 'character name', {})
    hide_character = TyranoDsl::WritingWords::HideCharacter.new
    assert_tyrano_exception('This action should take place in a scene') do
      hide_character.run(writing_context, world, caller, name: 'character name')
    end
  end

  def test_ok
    world = create_world
    writing_context = create_writing_context(world)
    writing_context.init_new_scene 'scene'
    declare_character(world, 'character name', {})
    hide_character = TyranoDsl::WritingWords::HideCharacter.new
    hide_character.run(writing_context, world, caller, name: 'character name')
    assert_equal(['[chara_hide name="character name" time="1000" wait="true"]'], writing_context.current_scene_content)
  end

end
