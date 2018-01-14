require_relative 'import_dsl_parsing_words_test_helper'

class ImportDslParsingWordsDeclareCharacterTest < Minitest::Test

  include ParsingWordsTestHelper

  def test_missing_background
    parser = create_parser
    assert_tyrano_exception("Missing file [#{full_path('missing_file.png')}]") do
      parser.declare_character('missing image', :default => 'missing_file.png')
    end
  end

  def test_duplicated_character
    parser = create_parser
    declare_character(parser.context.world, 'character', :default => '../../../assets/characters/shinji/default_stance.jpg')
    assert_tyrano_exception('Duplicated character [character]') do
      parser.declare_character('character', :default => '../../../assets/characters/shinji/default_stance.jpg')
    end
  end

  def test_no_default_stance
    parser = create_parser
    assert_tyrano_exception('A default stance is required') do
      parser.declare_character('character', :dab => '../../../assets/characters/shinji/default_stance.jpg')
    end
  end

  def test_ok
    parser = create_parser
    parser.declare_character('character', :default => '../../../assets/characters/shinji/default_stance.jpg')
    assert_equal(1, parser.context.world.characters.length)
    assert_equal('character', parser.context.world.characters.keys.first)
    character = parser.context.world.characters.values.first
    assert_equal('character', character.name)
    assert_equal(1, character.index)
    assert_equal(1, character.stances.length)
    assert_equal(:default, character.stances.keys.first)

    stance = character.stances.values.first
    assert_equal(:default, stance.name,)
    assert_equal(full_path('../../../assets/characters/shinji/default_stance.jpg'), stance.original_file_name)
    assert_equal('1/0.jpg', stance.short_target_file_name,)
    assert_equal('data/fgimage/chara/1/0.jpg', stance.long_target_file_name)

    default_stance = character.default_stance
    assert_equal(:default, default_stance.name)
    assert_equal(full_path('../../../assets/characters/shinji/default_stance.jpg'), default_stance.original_file_name,)
    assert_equal('1/0.jpg', default_stance.short_target_file_name,)
    assert_equal('data/fgimage/chara/1/0.jpg', default_stance.long_target_file_name)
    assert_word_equal(
        TyranoDsl::Vocabulary::DECLARE_CHARACTER,
        {
            :name => 'character',
            :stances => {default: full_path('../../../assets/characters/shinji/default_stance.jpg')},
            :default_stance => full_path('../../../assets/characters/shinji/default_stance.jpg')
        },
        parser
    )
  end

end
