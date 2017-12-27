require_relative 'parsing_words_test_helper'

class ParsingWordsDisplayTextTest < Minitest::Test

  include ParsingWordsTestHelper

  def test_missing_character
    parser = create_parser
    assert_tyrano_exception('Unknown character [Unknwown], currently 0 defined: ') do
      parser.display_text('Unknwown', 'blah')
    end
    parser = create_parser
    declare_character(parser.context.world, 'Shinji', :default => '../../assets/characters/shinji/default_stance.jpg')
    assert_tyrano_exception('Unknown character [Unknwown], currently 1 defined: [Shinji]') do
      parser.display_text('Unknwown', 'blah')
    end
  end

  def test_ok_with_character
    parser = create_parser
    declare_character(parser.context.world, 'Shinji', :default => '../../assets/characters/shinji/default_stance.jpg')
    parser.display_text('Shinji', 'Blah')
    assert_word_equal(
        TyranoDsl::Vocabulary::DISPLAY_TEXT,
        {:character_name => 'Shinji', :text => 'Blah'},
        parser
    )
  end

  def test_ok_without_character
    parser = create_parser
    parser.display_text(nil, 'Blah')
    assert_word_equal(
        TyranoDsl::Vocabulary::DISPLAY_TEXT,
        {:character_name => nil, :text => 'Blah'},
        parser
    )
  end

end
