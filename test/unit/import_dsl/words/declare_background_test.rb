require_relative 'words_base_test'

class ImportDslWords::DeclareBackgroundTest < ImportDslWords::WordsBaseTest

  def test_ok
    @parser.declare_background('background', '../../../assets/backgrounds/school.jpg')
    assert_word_equal(
        TyranoDsl::Vocabulary::DECLARE_BACKGROUND,
        background_name: 'background', image_path: full_path('../../../assets/backgrounds/school.jpg')
    )
  end

end
