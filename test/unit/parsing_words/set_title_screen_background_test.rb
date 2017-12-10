require_relative '../../../lib/tyrano_dsl/elements/background'
require_relative '../../../lib/tyrano_dsl/parser'
require_relative 'parsing_words_helper'

class SetTitleScreenBackgroundTest < Minitest::Test

  include ParsingWorldsHelper

  def test_unknown_background
    parser = create_parser
    begin
      parser.set_title_screen_background('missing background')
      fail
    rescue TyranoDsl::TyranoException => e
      assert_equal e.message, 'Line 12 unknown background [missing background], currently defined: '
    end
  end

  def test_two_backgrounds
    parser = create_parser
    parser.context.world.backgrounds['background 1'] = TyranoDsl::Elements::Background.new('background 1', 'background.png', 0)
    parser.set_title_screen_background('background 1')
    begin
      parser.set_title_screen_background('background 1')
      fail
    rescue TyranoDsl::TyranoException => e
      assert_equal e.message, 'Line 24 title screen background already defined'
    end
  end

  def test_ok
    parser = create_parser
    parser.context.world.backgrounds['background 1'] = TyranoDsl::Elements::Background.new('background 1', 'background.png', 0)
    parser.set_title_screen_background('background 1')
    assert_equal parser.context.words.length, 1
    assert_equal parser.context.words[0].word, TyranoDsl::Vocabulary::SET_TITLE_SCREEN_BACKGROUND
    assert_kind_of Array, parser.context.words[0].word_location
    assert_equal parser.context.words[0].parameters, {:name => "background 1"}
  end

end
