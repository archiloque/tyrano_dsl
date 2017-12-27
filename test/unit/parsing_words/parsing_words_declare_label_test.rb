require_relative 'parsing_words_test_helper'

class ParsingWordsDeclareLabelTest < Minitest::Test

  include ParsingWordsTestHelper

  def test_ok
    parser = create_parser
    parser.declare_label('my_label')
    assert_word_equal(
        TyranoDsl::Vocabulary::DECLARE_LABEL,
        {label_name: 'my_label'},
        parser
    )
  end

end
