require_relative 'words_base_test'

class ImportDslWords::DeclareVariableTest < ImportDslWords::WordsBaseTest

  def test_ok
    @parser.declare_variable('variable', 12)
    assert_word_equal(
        TyranoDsl::Vocabulary::DECLARE_VARIABLE,
        :variable_name => 'variable', :initial_value => 12
    )
  end

end
