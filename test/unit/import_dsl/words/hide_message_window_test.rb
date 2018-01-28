require_relative 'words_base_test'

class ImportDslWords::HideMessageWindowTest < ImportDslWords::WordsBaseTest

  def test_ok
    @parser.hide_message_window
    assert_word_equal(
        TyranoDsl::Vocabulary::HIDE_MESSAGE_WINDOW,
        {}
    )
  end

end
