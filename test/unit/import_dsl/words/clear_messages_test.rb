require_relative 'words_base_test'

class ImportDslWords::ClearMessagesTest < ImportDslWords::WordsBaseTest

  def test_ok
    @parser.clear_messages
    assert_word_equal(
        TyranoDsl::Vocabulary::CLEAR_MESSAGES,
        {}
    )
  end

end
