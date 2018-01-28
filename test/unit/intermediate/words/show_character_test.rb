require_relative '../../../../lib/tyrano_dsl/intermediate/words/show_character'
require_relative 'words_base_test'

class IntermediateWords::ShowCharacterTest < IntermediateWords::WordsBaseTest

  def setup
    super
    @show_character = TyranoDsl::Intermediate::Words::ShowCharacter.new
  end

  def test_missing_character
    assert_tyrano_exception('Unknown character [missing_character]') do
      @show_character.validation_phase(@context, @world, caller, character_name: 'missing_character')
    end
  end

  def test_missing_stance
    declare_character(@world, 'Shinji', :default => '../../assets/characters/shinji/default_stance.jpg')
    assert_tyrano_exception('Unknown stance [missing stance]') do
      @show_character.validation_phase(@context, @world, caller, character_name: 'Shinji', stance: 'missing stance')
    end
  end

  def test_ok
    declare_character(@world, 'Shinji', default: '../../assets/characters/shinji/default_stance.jpg')
    @show_character.validation_phase(@context, @world, caller, character_name: 'Shinji')
  end

end
