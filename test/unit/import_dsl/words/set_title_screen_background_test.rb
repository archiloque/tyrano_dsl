require_relative 'words_base_test'

class ImportDslWords::SetTitleScreenBackgroundTest < ImportDslWords::WordsBaseTest

  def test_ok
    @parser.set_title_screen_background('background 1')
    assert_word_equal(
        TyranoDsl::Vocabulary::SET_TITLE_SCREEN_BACKGROUND,
        background_name: 'background 1'
    )
  end

end
