require_relative 'words_base_test'
require_relative '../../../../lib/tyrano_dsl/export_tyrano/words/show_character'

class ExportTyranoWords::ShowCharacterTest < ExportTyranoWords::WordsBaseTest

  def setup
    super
    @show_character = TyranoDsl::ExportTyrano::Words::ShowCharacter.new
  end

  def test_ok_default_stance
    @context.init_new_scene 'scene'
    declare_scene(@world, 'scene name')
    declare_character(@world, 'character name', :default => 'default.png')
    @context.after_setup
    @show_character.run(@context, @world, character_name: 'character name', stance: :default, left: 10, top: 20)
    assert_equal([
                     '[chara_show name="character name" time="1000" wait="true" left="10" top="20" width="" height="" reflect="false"]'
                 ], @context.current_scene_content)
    assert_equal(1, @context.current_scene_assets.length)
    assert_equal('data/fgimage/chara/1/0.png', @context.current_scene_assets.to_a[0])
  end

  def test_ok_non_default_stance
    @world = create_world
    @context = create_context(@world)
    @context.init_new_scene 'scene'
    declare_scene(@world, 'scene name')
    declare_character(@world, 'character name', :default => 'default.png', :other => 'other.png')
    @context.after_setup
    @show_character.run(@context, @world, character_name: 'character name', stance: :other, left: 10, top: 20)
    assert_equal([
                     '[chara_show name="character name" time="1000" wait="true" left="10" top="20" width="" height="" reflect="false"]',
                     '[chara_mod name="character name" cross="true" storage="1/1.png"]'
                 ], @context.current_scene_content)
    assert_equal(2, @context.current_scene_assets.length)
    assert_equal('data/fgimage/chara/1/1.png', @context.current_scene_assets.to_a[0])
    assert_equal('data/fgimage/chara/1/0.png', @context.current_scene_assets.to_a[1])
  end

end
