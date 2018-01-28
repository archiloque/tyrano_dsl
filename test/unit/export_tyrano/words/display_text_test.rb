require_relative 'words_base_test'
require_relative '../../../../lib/tyrano_dsl/export_tyrano/words/display_text'

class ExportTyranoWords::DisplayTextTest < ExportTyranoWords::WordsBaseTest

  def setup
    super
    @display_text = TyranoDsl::ExportTyrano::Words::DisplayText.new
  end

  def test_ok_with_character
    @world = create_world
    @context = create_context(@world)
    @context.init_new_scene 'scene'
    declare_character(@world, 'character name', {})
    @display_text.run(@context, @world, character_name: 'character name', text: 'blah')
    assert_equal([
                     '[tb_start_text mode=1]
#character name
blah
[_tb_end_text]
'], @context.current_scene_content)
  end

  def test_ok_without_character
    @world = create_world
    @context = create_context(@world)
    @context.init_new_scene 'scene'
    @display_text.run(@context, @world, character_name: nil, text: 'blah')
    assert_equal(['[tb_start_text mode=1]
blah
[_tb_end_text]
'], @context.current_scene_content)
  end


end
