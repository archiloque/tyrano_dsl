require_relative 'parsing_words_test_helper'

class ParsingWordsDeclareBackgroundTest < Minitest::Test

  include ParsingWordsTestHelper

  def test_missing_background
    parser = create_parser
    assert_tyrano_exception("Missing file [#{full_path('missing_file.png')}]") do
      parser.declare_background('missing background', 'missing_file.png')
    end
  end

  def test_duplicated_background
    parser = create_parser
    declare_background(parser.context.world, 'background', '../../assets/backgrounds/school.jpg')
    assert_tyrano_exception('Duplicated background [background]') do
      parser.declare_background('background', '../../assets/backgrounds/school.jpg')
    end
  end

  def test_ok
    parser = create_parser
    parser.declare_background('background', '../../assets/backgrounds/school.jpg')
    assert_equal(1, parser.context.world.backgrounds.length)
    assert_equal('background', parser.context.world.backgrounds.keys.first)
    background = parser.context.world.backgrounds.values.first
    assert_equal('background', background.name,)
    assert_equal(full_path('../../assets/backgrounds/school.jpg'), background.image_path)
    assert_equal('1.jpg', background.target_short_file_name)
    assert_equal('data/bgimage/1.jpg', background.target_long_file_name)
    assert_word_equal(
        TyranoDsl::Vocabulary::DECLARE_BACKGROUND,
        {name: 'background', image_path: full_path('../../assets/backgrounds/school.jpg')},
        parser
    )
  end

end
