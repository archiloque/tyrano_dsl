require_relative 'parsing_words_helper'
require_relative '../../../lib/tyrano_dsl/parser'

class HideCharacterTest < Minitest::Test

  include ParsingWordsHelper

  def test_missing_character
    parser = create_parser
    begin
      parser.hide_character 'missing_character'
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match /Line \d+ unknown character \[missing_character\], currently defined: /, e.message
    end
  end

  def test_ok
    parser = create_parser
    declare_character(parser.context.world, 'Shinji', {default: '../../assets/characters/shinji/default_stance.jpg'})
    parser.hide_character 'Shinji'
    assert_equal parser.context.words.length, 1
    assert_equal parser.context.words[0].word, TyranoDsl::Vocabulary::HIDE_CHARACTER
    assert_kind_of Array, parser.context.words[0].word_location
    assert_equal parser.context.words[0].parameters, {:name => 'Shinji'}
  end

end
