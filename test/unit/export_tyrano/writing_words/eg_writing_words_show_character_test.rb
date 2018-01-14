require_relative 'eg_writing_words_helper'
require_relative '../../../../lib/tyrano_dsl/export_tyrano/writing_words/show_character'

class EGWritingWordsShowCharacterTest < Minitest::Test

  include EGWritingWordsHelper

  def test_no_current_scene
    world = create_world
    writing_context = create_writing_context(world)
    declare_scene(world, 'scene name')
    declare_character(world, 'character name', :default => 'default.png')
    show_character = TyranoDsl::ExportTyrano::WritingWords::ShowCharacter.new
    assert_tyrano_exception('This action should take place in a scene') do
      show_character.run(writing_context, world, caller, name: 'character name', stance: :default, left: 10, top: 20)
    end
  end

  def test_ok_default_stance
    world = create_world
    writing_context = create_writing_context(world)
    writing_context.init_new_scene 'scene'
    declare_scene(world, 'scene name')
    declare_character(world, 'character name', :default => 'default.png')
    show_character = TyranoDsl::ExportTyrano::WritingWords::ShowCharacter.new
    show_character.run(writing_context, world, caller, name: 'character name', stance: :default, left: 10, top: 20)
    assert_equal([
                     '[chara_show name="character name" time="1000" wait="true" left="10" top="20" width="" height="" reflect="false"]'
                 ], writing_context.current_scene_content)
    assert_equal(1, writing_context.current_scene_assets.length)
    assert_equal('data/fgimage/chara/1/0.png', writing_context.current_scene_assets.to_a[0])
  end

  def test_ok_non_default_stance
    world = create_world
    writing_context = create_writing_context(world)
    writing_context.init_new_scene 'scene'
    declare_scene(world, 'scene name')
    declare_character(world, 'character name', :default => 'default.png', :other => 'other.png')
    show_character = TyranoDsl::ExportTyrano::WritingWords::ShowCharacter.new
    show_character.run(writing_context, world, caller, name: 'character name', stance: :other, left: 10, top: 20)
    assert_equal([
                     '[chara_show name="character name" time="1000" wait="true" left="10" top="20" width="" height="" reflect="false"]',
                     '[chara_mod name="character name" cross="true" storage="1/1.png"]'
                 ], writing_context.current_scene_content)
    assert_equal(2, writing_context.current_scene_assets.length)
    assert_equal('data/fgimage/chara/1/1.png', writing_context.current_scene_assets.to_a[0])
    assert_equal('data/fgimage/chara/1/0.png', writing_context.current_scene_assets.to_a[1])
  end

end
