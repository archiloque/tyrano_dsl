require_relative 'parsing_words_helper'
require_relative '../../../lib/tyrano_dsl/parser'

class ShowCharacterTest < Minitest::Test

  include ParsingWordsHelper

  def test_missing_character
    parser = create_parser
    begin
      parser.show_character 'missing_character', 'dab', 10, 10
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match(/Line \d+ unknown character \[missing_character\], currently defined: /, e.message)
    end
  end

  def test_missing_stance
    parser = create_parser
    declare_character(parser.context.world, 'Shinji', {:default => '../../assets/characters/shinji/default_stance.jpg'})
    begin
      parser.show_character 'Shinji', 'missing stance', 10, 10
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match(/Line \d+ unknown stance \[missing stance\], currently defined: default/, e.message)
    end
  end

  def test_ok
    parser = create_parser
    declare_character(parser.context.world, 'Shinji', {default: '../../assets/characters/shinji/default_stance.jpg'})
    parser.show_character 'Shinji', :default, 10, 10
    assert_equal(parser.context.words.length, 1)
    assert_equal(parser.context.words[0].word, TyranoDsl::Vocabulary::SHOW_CHARACTER)
    assert_kind_of(Array, parser.context.words[0].word_location)
    assert_equal(parser.context.words[0].parameters, {:name => 'Shinji', :stance => :default, :left => 10, :top => 10})
  end

end
