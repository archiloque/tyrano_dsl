require_relative 'parsing_words_test_helper'

class ParsingWordsSetCharacterStanceTest < Minitest::Test

  include ParsingWordsTestHelper

  def test_missing_character
    parser = create_parser
    begin
      parser.set_character_stance 'missing_character', 'dab'
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match(/Line \d+ unknown character \[missing_character\], currently defined: /, e.message)
    end
  end

  def test_missing_stance
    parser = create_parser
    declare_character(parser.context.world, 'Shinji', :default => '../../assets/characters/shinji/default_stance.jpg')
    begin
      parser.set_character_stance 'Shinji', 'missing stance'
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match(/Line \d+ unknown stance \[missing stance\], currently defined: default/, e.message)
    end
  end

  def test_ok
    parser = create_parser
    declare_character(parser.context.world, 'Shinji', default: '../../assets/characters/shinji/default_stance.jpg', :angry => '../../assets/characters/shinji/angry.png')
    parser.set_character_stance 'Shinji', 'angry'
    assert_equal(parser.context.words.length, 1)
    assert_equal(parser.context.words[0].word, TyranoDsl::Vocabulary::SET_CHARACTER_STANCE)
    assert_kind_of(Array, parser.context.words[0].word_location)
    assert_equal(parser.context.words[0].parameters, :name => 'Shinji', :stance => :angry)
  end

end
