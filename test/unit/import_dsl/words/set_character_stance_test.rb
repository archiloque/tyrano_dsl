require_relative 'words_base_test'

class ImportDslWords::SetCharacterStanceTest < ImportDslWords::WordsBaseTest

  def test_ok_default
    @parser = create_parser
    @parser.set_character_stance 'Shinji', 'angry'
    assert_word_equal(
        TyranoDsl::Vocabulary::SET_CHARACTER_STANCE,
        character_name: 'Shinji',
        stance: :angry,
        duration: 600
    )
  end

  def test_ok
    @parser = create_parser
    @parser.set_character_stance 'Shinji', 'angry', 250
    assert_word_equal(
        TyranoDsl::Vocabulary::SET_CHARACTER_STANCE,
        character_name: 'Shinji',
        stance: :angry,
        duration: 250
    )
  end

end
