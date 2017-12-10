require_relative 'parsing_words_helper'
require_relative '../../../lib/tyrano_dsl/parser'

class SetBackgroundTest < Minitest::Test

  include ParsingWorldsHelper

  def test_missing_character
    parser = create_parser
    begin
      parser.set_background 'missing_background'
      fail
    rescue TyranoDsl::TyranoException => e
      assert_equal e.message, 'Line 11 unknown background [missing_background], currently defined: '
    end
  end

  def test_ok
    parser = create_parser
    parser.context.world.backgrounds['background'] = TyranoDsl::Elements::Background.new(
        'background',
        '../../assets/backgrounds/school.jpg',
        1
    )
    parser.set_background 'background'
    assert_equal parser.context.words.length, 1
    assert_equal parser.context.words[0].word, TyranoDsl::Vocabulary::SET_BACKGROUND
    assert_kind_of Array, parser.context.words[0].word_location
    assert_equal parser.context.words[0].parameters, :name => "background"

  end

end
