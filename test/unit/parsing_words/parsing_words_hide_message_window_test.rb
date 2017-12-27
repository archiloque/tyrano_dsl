require_relative 'parsing_words_test_helper'

class ParsingWordsHideMessageWindowTest < Minitest::Test

  include ParsingWordsTestHelper

  def test_ok
    parser = create_parser
    parser.hide_message_window
    assert_word_equal(
        TyranoDsl::Vocabulary::HIDE_MESSAGE_WINDOW,
        {},
        parser
    )
  end

end
