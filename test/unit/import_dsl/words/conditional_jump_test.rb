require_relative 'words_base_test'

class ImportDslWords::ConditionalJumpTest < ImportDslWords::WordsBaseTest

  def test_ok_variable
    @parser.conditional_jump('a', '<', 'b', 'target scene', 'target label')
    assert_word_equal(
        TyranoDsl::Vocabulary::CONDITIONAL_JUMP,
        {:variable => 'a', :operator => '<', :value => 'b', :scene_name => 'target scene', :label_name => 'target label'}
    )
  end

  def test_ok_value
    @parser.conditional_jump('a', '<', 20, 'target scene', 'target label')
    assert_word_equal(
        TyranoDsl::Vocabulary::CONDITIONAL_JUMP,
        {:variable => 'a', :operator => '<', :value => 20, :scene_name => 'target scene', :label_name => 'target label'}
    )
  end

end
