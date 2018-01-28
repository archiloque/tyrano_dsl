require_relative 'words_base_test'

class ImportDslWords::DisplayTextTest < ImportDslWords::WordsBaseTest

  def test_ok_with_character
    @parser.display_text('Shinji', 'Blah')
    assert_word_equal(
        TyranoDsl::Vocabulary::DISPLAY_TEXT,
        :character_name => 'Shinji', :text => 'Blah'
    )
  end

  def test_ok_without_character
    @parser.display_text(nil, 'Blah')
    assert_word_equal(
        TyranoDsl::Vocabulary::DISPLAY_TEXT,
        :character_name => nil, :text => 'Blah'
    )
  end

end
