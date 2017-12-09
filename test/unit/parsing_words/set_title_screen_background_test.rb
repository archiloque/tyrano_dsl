require_relative '../../test_helper'
require_relative '../../../lib/tyrano_dsl/elements/background'
require_relative '../../../lib/tyrano_dsl/parser'
require_relative '../../../lib/tyrano_dsl/parsing_context'

class SetTitleScreenBackgroundTest < Minitest::Test

  include TyranoDsl::ParsingWords::SetTitleScreenBackground

  def test_unknown_background
    parsing_context = create_parsing_context
    parser = TyranoDsl::Parser.new(parsing_context)
    begin
      parser.set_title_screen_background('missing background')
      fail
    rescue TyranoDsl::TyranoException => e
      assert_equal e.message, 'Line 14 unknown background [missing background], currently defined: '
    end
  end

  def test_two_backgrounds
    parsing_context = create_parsing_context
    parsing_context.world.backgrounds['background 1'] = TyranoDsl::Elements::Background.new('background 1', 'background.png', 0)
    parser = TyranoDsl::Parser.new(parsing_context)
    parser.set_title_screen_background('background 1')
    begin
      parser.set_title_screen_background('background 1')
      fail
    rescue TyranoDsl::TyranoException => e
      assert_equal e.message, 'Line 27 title screen background already defined'
    end
  end

  def test_ok
    parsing_context = create_parsing_context
    parsing_context.world.backgrounds['background 1'] = TyranoDsl::Elements::Background.new('background 1', 'background.png', 0)
    parser = TyranoDsl::Parser.new(parsing_context)
    parser.set_title_screen_background('background 1')
    assert_equal parsing_context.words.length, 1
    assert_equal parsing_context.words[0].word, TyranoDsl::Vocabulary::SET_TITLE_SCREEN_BACKGROUND
    assert_kind_of Array, parsing_context.words[0].word_location
    assert_equal parsing_context.words[0].parameters, {:name => "background 1"}
  end

  private

  def create_parsing_context
    TyranoDsl::ParsingContext.new(File.dirname(__FILE__), __FILE__)
  end

end
