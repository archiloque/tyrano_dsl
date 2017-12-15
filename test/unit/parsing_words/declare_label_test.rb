require_relative 'parsing_words_helper'
require_relative '../../../lib/tyrano_dsl/parser'

class DeclareLabelTest < Minitest::Test

  include ParsingWordsHelper

  def test_ok
    parser = create_parser
    parser.declare_label('my_label')
    assert_equal parser.context.words[0].word, TyranoDsl::Vocabulary::DECLARE_LABEL
    assert_kind_of Array, parser.context.words[0].word_location
    assert_equal parser.context.words[0].parameters, {label_name: 'my_label'}
  end

end
