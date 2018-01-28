require_relative 'words_base_test'

class ImportDslWords::SetBackgroundTest < ImportDslWords::WordsBaseTest

  def test_ok
    @parser.set_background 'background'
    assert_word_equal(
        TyranoDsl::Vocabulary::SET_BACKGROUND,
        background_name: 'background'
    )
  end

end
