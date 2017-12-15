require_relative 'parsing_words_helper'
require_relative '../../../lib/tyrano_dsl/parser'

class DeclareCharacterTest < Minitest::Test

  include ParsingWordsHelper

  def test_missing_background
    parser = create_parser
    begin
      parser.declare_character('missing image', {:default => 'missing_file.png'})
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match /Line \d+ missing file \[missing_file.png\]/, e.message
    end
  end

  def test_duplicated_character
    parser = create_parser
    parser.declare_character('character', {:default => '../../assets/characters/shinji/default_stance.jpg'})
    begin
      parser.declare_character('character', {:default => '../../assets/characters/shinji/default_stance.jpg'})
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match /Line \d+ duplicated character \[character\]/, e.message
    end
  end

  def test_no_default_stance
    parser = create_parser
    begin
      parser.declare_character('character', {:dab => '../../assets/characters/shinji/default_stance.jpg'})
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match /Line \d+ you need a default stance/, e.message
    end
  end

  def test_ok
    parser = create_parser
    parser.declare_character('character', {:default => '../../assets/characters/shinji/default_stance.jpg'})
    assert_equal parser.context.world.characters.length, 1
    assert_equal parser.context.world.characters.keys.first, 'character'
    character = parser.context.world.characters.values.first
    assert_equal character.name, 'character'
    assert_equal character.index, 1
    assert_equal character.stances.length, 1
    assert_equal character.stances.keys.first, :default

    stance = character.stances.values.first
    assert_equal stance.name, :default
    assert_equal stance.original_file_name, '../../assets/characters/shinji/default_stance.jpg'
    assert_equal stance.short_target_file_name, '1/0.jpg'
    assert_equal stance.long_target_file_name, 'data/fgimage/chara/1/0.jpg'

    default_stance = character.default_stance
    assert_equal default_stance.name, :default
    assert_equal default_stance.original_file_name, '../../assets/characters/shinji/default_stance.jpg'
    assert_equal default_stance.short_target_file_name, '1/0.jpg'
    assert_equal default_stance.long_target_file_name, 'data/fgimage/chara/1/0.jpg'

    assert_equal parser.context.words[0].word, TyranoDsl::Vocabulary::DECLARE_CHARACTER
    assert_kind_of Array, parser.context.words[0].word_location
    assert_equal parser.context.words[0].parameters, {
        :name => 'character',
        :stances => {default: '../../assets/characters/shinji/default_stance.jpg'},
        :default_stance => '../../assets/characters/shinji/default_stance.jpg'
    }
  end

end
