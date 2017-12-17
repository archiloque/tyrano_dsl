require_relative 'parsing_words_helper'
require_relative '../../../lib/tyrano_dsl/parser'

class SetBackgroundTest < Minitest::Test

  include ParsingWordsHelper

  def test_missing_background
    parser = create_parser
    begin
      parser.set_background 'missing_background'
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match /Line \d+ unknown background \[missing_background\], currently defined: /, e.message
    end
  end

  def test_ok
    parser = create_parser
    declare_background(parser.context.world, 'background', '../../assets/backgrounds/school.jpg')
    parser.set_background 'background'
    assert_equal parser.context.words.length, 1
    assert_equal parser.context.words[0].word, TyranoDsl::Vocabulary::SET_BACKGROUND
    assert_kind_of Array, parser.context.words[0].word_location
    assert_equal parser.context.words[0].parameters, {name: 'background'}
  end

end
