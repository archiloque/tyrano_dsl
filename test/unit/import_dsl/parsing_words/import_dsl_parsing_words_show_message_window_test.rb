require_relative 'import_dsl_parsing_words_test_helper'

class ImportDslParsingWordsShowMessageWindowTest < Minitest::Test

  include ParsingWordsTestHelper

  def test_ok
    parser = create_parser
    parser.show_message_window
    assert_word_equal(
        TyranoDsl::Vocabulary::SHOW_MESSAGE_WINDOW,
        {},
        parser
    )
  end

end
