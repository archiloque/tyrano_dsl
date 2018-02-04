require_relative 'words_base_test'

class ImportDslWords::DeclareVariableTest < ImportDslWords::WordsBaseTest

  def test_ok_string
    @parser.declare_variable('variable', 'yolo')
    assert_word_equal(
        TyranoDsl::Vocabulary::DECLARE_VARIABLE,
        :variable_name => 'variable',
        :initial_value => 'yolo',
        )
  end

  def test_ok_float
    @parser.declare_variable('variable', 12)
    assert_word_equal(
        TyranoDsl::Vocabulary::DECLARE_VARIABLE,
        :variable_name => 'variable',
        :initial_value => 12,
        )
  end

  def test_ok_no_value
    @parser.declare_variable('variable')
    assert_word_equal(
        TyranoDsl::Vocabulary::DECLARE_VARIABLE,
        :variable_name => 'variable',
        )
  end

end
