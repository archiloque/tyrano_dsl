require_relative 'import_dsl_parsing_words_test_helper'

class ImportDslParsingWordsHideMessageWindowTest < Minitest::Test

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
