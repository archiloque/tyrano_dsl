require_relative 'import_dsl_parsing_words_test_helper'

class ImportDslParsingWordsSetTitleScreenBackgroundTest < Minitest::Test

  include ParsingWordsTestHelper

  def test_unknown_background
    parser = create_parser
    assert_tyrano_exception('Unknown background [missing background], currently 0 defined: ') do
      parser.set_title_screen_background('missing background')
    end

    parser = create_parser
    declare_background(parser.context.world, 'background 1', 'background.png')
    assert_tyrano_exception('Unknown background [missing background], currently 1 defined: [background 1]') do
      parser.set_title_screen_background('missing background')
    end
  end

  def test_two_backgrounds
    parser = create_parser
    declare_background(parser.context.world, 'background 1', 'background.png')
    parser.set_title_screen_background('background 1')
    assert_tyrano_exception('Title screen background already defined') do
      parser.set_title_screen_background('background 1')
    end
  end

  def test_ok
    parser = create_parser
    declare_background(parser.context.world, 'background 1', 'background.png')
    parser.set_title_screen_background('background 1')
    assert_word_equal(
        TyranoDsl::Vocabulary::SET_TITLE_SCREEN_BACKGROUND,
        {name: 'background 1'},
        parser
    )
  end

end
