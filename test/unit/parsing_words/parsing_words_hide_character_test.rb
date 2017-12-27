require_relative 'parsing_words_test_helper'

class ParsingWordsHideCharacterTest < Minitest::Test

  include ParsingWordsTestHelper

  def test_missing_character
    parser = create_parser
    assert_tyrano_exception('Unknown character [missing_character], currently 0 defined: ') do
      parser.hide_character 'missing_character'
    end

    parser = create_parser
    declare_character(parser.context.world, 'Shinji', default: '../../assets/characters/shinji/default_stance.jpg')
    assert_tyrano_exception('Unknown character [missing_character], currently 1 defined: [Shinji]') do
      parser.hide_character 'missing_character'
    end
  end

  def test_ok
    parser = create_parser
    declare_character(parser.context.world, 'Shinji', default: '../../assets/characters/shinji/default_stance.jpg')
    parser.hide_character 'Shinji'
    assert_word_equal(
        TyranoDsl::Vocabulary::HIDE_CHARACTER,
        {:name => 'Shinji'},
        parser
    )
  end

end
