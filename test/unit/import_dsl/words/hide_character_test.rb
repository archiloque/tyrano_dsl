require_relative 'words_base_test'

class ImportDslWords::HideCharacterTest < ImportDslWords::WordsBaseTest

  def test_ok
    @parser.hide_character 'Shinji'
    assert_word_equal(
        TyranoDsl::Vocabulary::HIDE_CHARACTER,
        :character_name => 'Shinji'
    )
  end

end
