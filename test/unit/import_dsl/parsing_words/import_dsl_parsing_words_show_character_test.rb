require_relative 'import_dsl_parsing_words_test_helper'

class ImportDslParsingWordsShowCharacterTest < Minitest::Test

  include ParsingWordsTestHelper

  def test_missing_character
    parser = create_parser
    assert_tyrano_exception('Unknown character [missing_character], currently 0 defined: ') do
      parser.show_character 'missing_character', 'dab', 10, 10
    end
    parser = create_parser
    declare_character(parser.context.world, 'Shinji', :default => '../../assets/characters/shinji/default_stance.jpg')
    assert_tyrano_exception('Unknown character [missing_character], currently 1 defined: [Shinji]') do
      parser.show_character 'missing_character', 'dab', 10, 10
    end
  end

  def test_missing_stance
    parser = create_parser
    declare_character(parser.context.world, 'Shinji', :default => '../../assets/characters/shinji/default_stance.jpg')
    assert_tyrano_exception('Unknown stance [missing stance], currently 1 defined: [default]') do
      parser.show_character 'Shinji', 'missing stance', 10, 10
    end
  end

  def test_ok
    parser = create_parser
    declare_character(parser.context.world, 'Shinji', default: '../../assets/characters/shinji/default_stance.jpg')
    parser.show_character 'Shinji', :default, 10, 10
    assert_word_equal(
        TyranoDsl::Vocabulary::SHOW_CHARACTER,
        {:name => 'Shinji', :stance => :default, :left => 10, :top => 10},
        parser
    )
  end

end
