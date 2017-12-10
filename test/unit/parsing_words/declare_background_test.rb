require_relative 'parsing_words_helper'
require_relative '../../../lib/tyrano_dsl/parser'

class DeclareBackgroundTest < Minitest::Test

  include ParsingWorldsHelper

  def test_missing_background
    parser = create_parser
    begin
      parser.declare_background('missing background', 'missing_file.png')
      fail
    rescue TyranoDsl::TyranoException => e
      assert_equal e.message, 'Line 11 missing file [missing_file.png]'
    end
  end

  def test_duplicated_background
    parser = create_parser
    parser.declare_background('background', '../../assets/backgrounds/school.jpg')
    begin
      parser.declare_background('background', '../../assets/backgrounds/school.jpg')
      fail
    rescue TyranoDsl::TyranoException => e
      assert_equal e.message, 'Line 22 duplicated background [background]'
    end
  end

  def test_ok
    parser = create_parser
    parser.declare_background('background', '../../assets/backgrounds/school.jpg')
    assert_equal parser.context.world.backgrounds.length, 1
    assert_equal parser.context.world.backgrounds.keys.first, 'background'
    assert_equal parser.context.world.backgrounds.values.first.name, 'background'
    assert_equal parser.context.world.backgrounds.values.first.image_path, '../../assets/backgrounds/school.jpg'
    assert_equal parser.context.world.backgrounds.values.first.target_short_file_name, '1.jpg'
    assert_equal parser.context.world.backgrounds.values.first.target_long_file_name, 'data/bgimage/1.jpg'
    assert_equal parser.context.words[0].word, TyranoDsl::Vocabulary::DECLARE_BACKGROUND
    assert_kind_of Array, parser.context.words[0].word_location
    assert_equal parser.context.words[0].parameters, {:name=>"background", :image_path=>"../../assets/backgrounds/school.jpg"}
  end


end
