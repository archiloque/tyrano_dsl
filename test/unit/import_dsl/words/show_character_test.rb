require_relative 'words_base_test'

class ImportDslWords::ShowCharacterTest < ImportDslWords::WordsBaseTest

  def test_ok
    @parser.show_character 'Shinji', :default, 10, 10
    assert_word_equal(
        TyranoDsl::Vocabulary::SHOW_CHARACTER,
        :character_name => 'Shinji', :stance => :default, :left => 10, :top => 10
    )
  end

end
