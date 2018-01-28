require_relative 'words_base_test'
require_relative '../../../../lib/tyrano_dsl/export_tyrano/words/set_character_stance'

class ExportTyranoWords::SetCharacterStanceTest < ExportTyranoWords::WordsBaseTest

  def setup
    super
    @set_character_stance = TyranoDsl::ExportTyrano::Words::SetCharacterStance.new
  end

  def test_ok
    @context.init_new_scene 'scene'
    declare_scene(@world, 'scene name')
    declare_character(@world, 'character name', :default => 'default.png')
    @context.after_setup
    @set_character_stance.run(@context, @world, character_name: 'character name', stance: :default)
    assert_equal([
                     '[chara_mod name="character name" cross="true" storage="chara/1/0.png"]'
                 ], @context.current_scene_content)
    assert_equal(1, @context.current_scene_assets.length)
    assert_equal('data/fgimage/chara/1/0.png', @context.current_scene_assets.to_a[0])
  end

end
