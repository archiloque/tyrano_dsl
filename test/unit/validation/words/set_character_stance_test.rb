require_relative '../../../../lib/tyrano_dsl/validation/words/set_character_stance'
require_relative 'words_base_test'

class ValidationWords::SetCharacterStanceTest < ValidationWords::WordsBaseTest

  def setup
    super
    @set_character_stance = TyranoDsl::Validation::Words::SetCharacterStance.new
  end

  def test_missing_character
    assert_tyrano_exception('Unknown character [missing_character]') do
      @set_character_stance.validation_phase(@context, @world, caller, character_name: 'missing_character')
    end
  end

  def test_missing_stance
    declare_character(@world, 'Shinji', :default => '../../assets/characters/shinji/default_stance.jpg')
    assert_tyrano_exception('Unknown stance [missing_stance]') do
      @set_character_stance.validation_phase(@context, @world, caller, character_name: 'Shinji', stance: :missing_stance)
    end
  end

  def test_ok
    declare_character(@world, 'Shinji', :default => '../../assets/characters/shinji/default_stance.jpg')
    @set_character_stance.validation_phase(@context, @world, caller, character_name: 'Shinji', stance: :default)
  end

end
