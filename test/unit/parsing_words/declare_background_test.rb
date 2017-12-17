require_relative 'parsing_words_helper'
require_relative '../../../lib/tyrano_dsl/parser'

class DeclareBackgroundTest < Minitest::Test

  include ParsingWordsHelper

  def test_missing_background
    parser = create_parser
    begin
      parser.declare_background('missing background', 'missing_file.png')
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match /Line \d+ missing file \[missing_file.png\]/, e.message
    end
  end

  def test_duplicated_background
    parser = create_parser
    declare_background(parser.context.world, 'background', '../../assets/backgrounds/school.jpg')
    begin
      parser.declare_background('background', '../../assets/backgrounds/school.jpg')
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match /Line \d+ duplicated background \[background\]/, e.message
    end
  end

  def test_ok
    parser = create_parser
    parser.declare_background('background', '../../assets/backgrounds/school.jpg')
    assert_equal parser.context.world.backgrounds.length, 1
    assert_equal parser.context.world.backgrounds.keys.first, 'background'
    background = parser.context.world.backgrounds.values.first
    assert_equal background.name, 'background'
    assert_equal background.image_path, '../../assets/backgrounds/school.jpg'
    assert_equal background.target_short_file_name, '1.jpg'
    assert_equal background.target_long_file_name, 'data/bgimage/1.jpg'
    assert_equal parser.context.words[0].word, TyranoDsl::Vocabulary::DECLARE_BACKGROUND
    assert_kind_of Array, parser.context.words[0].word_location
    assert_equal parser.context.words[0].parameters, {name: 'background', :image_path => '../../assets/backgrounds/school.jpg'}
  end

end
