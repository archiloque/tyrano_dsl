require_relative 'parsing_words_helper'
require_relative '../../../lib/tyrano_dsl/parser'

class DisplayTextTest < Minitest::Test

  include ParsingWordsHelper

  def test_missing_character
    parser = create_parser
    begin
      parser.display_text('Unknwown', 'blah')
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match /Line \d+ unknown character \[Unknwown\], currently defined: /, e.message
    end
  end

  def test_ok_with_character
    parser = create_parser
    declare_character(parser.context.world, 'Shinji', {:default => '../../assets/characters/shinji/default_stance.jpg'})
    parser.display_text('Shinji', 'Blah')
    assert_equal parser.context.words[0].word, TyranoDsl::Vocabulary::DECLARE_CHARACTER
    assert_kind_of Array, parser.context.words[0].word_location
    assert_equal parser.context.words[0].parameters, {name: 'background', :image_path => '../../assets/backgrounds/school.jpg'}
  end

  def test_ok_without_character
    parser = create_parser
    parser.display_text(nil, 'Blah')
    assert_equal parser.context.words[0].word, TyranoDsl::Vocabulary::DECLARE_CHARACTER
    assert_kind_of Array, parser.context.words[0].word_location
    assert_equal parser.context.words[0].parameters, {name: 'background', :image_path => '../../assets/backgrounds/school.jpg'}
  end

end
