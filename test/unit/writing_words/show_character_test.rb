require_relative 'writing_words_helper'
require_relative '../../../lib/tyrano_dsl/parser'
require_relative '../../../lib/tyrano_dsl/writing_words/show_character'

class ShowCharacterTest < Minitest::Test

  include WritingWordsHelper

  def test_no_current_scene
    world = create_world
    writing_context = create_writing_context(world)
    world.scenes['scene name'] = TyranoDsl::Elements::Scene.new('scene name', 0)
    world.characters['character name'] = TyranoDsl::Elements::Character.new('character name', {:default => 'default.png'}, 0)
    show_character = TyranoDsl::WritingWords::ShowCharacter.new
    begin
      show_character.run(writing_context, world, caller_locations, {name: 'character name', stance: :default, left: 10, top: 20})
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match /Line \d+ this action should take place in a scene/, e.message
    end
  end

  def test_ok
    world = create_world
    writing_context = create_writing_context(world)
    writing_context.init_new_scene 'scene'
    world.characters['character name'] = TyranoDsl::Elements::Character.new('character name', {:default => 'default.png'}, 0)
    show_character = TyranoDsl::WritingWords::ShowCharacter.new
    show_character.run(writing_context, world, caller_locations, {name: 'character name', stance: :default, left: 10, top: 20})
    assert_equal writing_context.current_scene_content, ['[chara_show name="character name" time="1000" wait="true" left="10" top="20" width="" height="" reflect="false"]']
    assert_equal writing_context.current_scene_assets.length, 1
    assert_equal writing_context.current_scene_assets.to_a[0], 'data/fgimage/chara/0/0.png'
  end


end
