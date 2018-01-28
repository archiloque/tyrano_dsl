require_relative 'words_base_test'

class ImportDslWords::JumpTest < ImportDslWords::WordsBaseTest

  def test_ok_with_scene
    @parser.jump('target scene', 'target label')
    assert_word_equal(
        TyranoDsl::Vocabulary::JUMP,
        scene_name: 'target scene',
        :label_name => 'target label'
    )
  end

  def test_ok_without_scene
    @parser.jump('target scene')
    assert_word_equal(
        TyranoDsl::Vocabulary::JUMP,
        scene_name: 'target scene',
        :label_name => nil
    )
  end

end
