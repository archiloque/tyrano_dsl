require_relative 'parsing_words_test_helper'

class ParsingWordsSetCharacterStanceTest < Minitest::Test

  include ParsingWordsTestHelper

  def test_missing_character
    parser = create_parser
    assert_tyrano_exception('Unknown character [missing_character], currently 0 defined: ') do
      parser.set_character_stance 'missing_character', 'dab'
    end
  end

  def test_missing_stance
    parser = create_parser
    declare_character(parser.context.world, 'Shinji', :default => '../../assets/characters/shinji/default_stance.jpg')
    assert_tyrano_exception('Unknown stance [missing stance], currently 1 defined: [default]') do
      parser.set_character_stance 'Shinji', 'missing stance'
    end
  end

  def test_ok
    parser = create_parser
    declare_character(parser.context.world, 'Shinji', default: '../../assets/characters/shinji/default_stance.jpg', :angry => '../../assets/characters/shinji/angry.png')
    parser.set_character_stance 'Shinji', 'angry'
    assert_word_equal(
        TyranoDsl::Vocabulary::SET_CHARACTER_STANCE,
        {:name => 'Shinji', :stance => :angry},
        parser
    )
  end

end
