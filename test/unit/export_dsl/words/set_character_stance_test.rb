require_relative 'export_dsl_words_base_test'
require_relative '../../../../lib/tyrano_dsl/export_dsl/words/set_character_stance'

class ExportDslWords::SetCharacterStanceTest < ExportDslWords::WordsBaseTest

  def test_ok
    @context.init_new_scene('scene')
    set_character_stance = TyranoDsl::ExportDsl::Words::SetCharacterStance.new
    set_character_stance.run(@context,
                             character_name: 'shinji',
                             stance: 'sad',
                             duration: 300)
    @context.end_writing
    assert_file('scene.rb', 'set_character_stance "shinji", "sad", 300')
  end


  def test_default
    @context.init_new_scene('scene')
    set_character_stance = TyranoDsl::ExportDsl::Words::SetCharacterStance.new
    set_character_stance.run(@context,
                             character_name: 'shinji',
                             stance: 'sad',
                             duration: 600)
    @context.end_writing
    assert_file('scene.rb', 'set_character_stance "shinji", "sad"')
  end

end
