require_relative 'words_base_test'

class ImportDslWords::ShowMessageWindowTest < ImportDslWords::WordsBaseTest

  def test_ok
    @parser.show_message_window
    assert_word_equal(
        TyranoDsl::Vocabulary::SHOW_MESSAGE_WINDOW,
        {}
    )
  end

end
