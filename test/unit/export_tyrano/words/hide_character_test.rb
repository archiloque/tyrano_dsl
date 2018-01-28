require_relative 'words_base_test'
require_relative '../../../../lib/tyrano_dsl/export_tyrano/words/hide_character'

class ExportTyranoWords::HideCharacterTest < ExportTyranoWords::WordsBaseTest

  def setup
    super
    @hide_character = TyranoDsl::ExportTyrano::Words::HideCharacter.new
  end

  def test_ok
    @context.init_new_scene 'scene'
    declare_character(@world, 'character name', {})
    @hide_character.run(@context, @world, character_name: 'character name')
    assert_equal(['[chara_hide name="character name" time="1000" wait="true"]'], @context.current_scene_content)
  end

end
