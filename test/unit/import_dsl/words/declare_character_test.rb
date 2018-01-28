require_relative 'words_base_test'

class ImportDslWords::DeclareCharacterTest < ImportDslWords::WordsBaseTest

  def test_ok
    @parser.declare_character('character', :default => '../../../assets/characters/shinji/default_stance.jpg')
    assert_word_equal(
        TyranoDsl::Vocabulary::DECLARE_CHARACTER,

        :character_name => 'character',
        :stances => {default: full_path('../../../assets/characters/shinji/default_stance.jpg')}
    )
  end

end
