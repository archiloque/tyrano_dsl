require_relative 'words_base_test'

class ImportDslWords::UpdateVariableTest < ImportDslWords::WordsBaseTest

  def test_ok_variable
    @parser.update_variable('a', '=', 'b')
    assert_word_equal(
        TyranoDsl::Vocabulary::UPDATE_VARIABLE,
        :variable => 'a', :operator => '=', :value => 'b'
    )
  end

  def test_ok_value
    @parser = create_parser
    @parser.update_variable('a', '=', 20,)
    assert_word_equal(
        TyranoDsl::Vocabulary::UPDATE_VARIABLE,
        :variable => 'a', :operator => '=', :value => 20
    )
  end


end
