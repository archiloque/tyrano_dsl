require_relative 'parsing_words_test_helper'

class ParsingWordsSetBackgroundTest < Minitest::Test

  include ParsingWordsTestHelper

  def test_missing_background
    parser = create_parser
    assert_tyrano_exception('Unknown background [missing_background], currently 0 defined: ') do
      parser.set_background 'missing_background'
    end

    parser = create_parser
    declare_background(parser.context.world, 'background 1', 'background.png')
    assert_tyrano_exception('Unknown background [missing_background], currently 1 defined: [background 1]') do
      parser.set_background 'missing_background'
    end
  end

  def test_ok
    parser = create_parser
    declare_background(parser.context.world, 'background', '../../assets/backgrounds/school.jpg')
    parser.set_background 'background'
    assert_word_equal(
        TyranoDsl::Vocabulary::SET_BACKGROUND,
        {name: 'background'},
        parser
    )
  end

end
