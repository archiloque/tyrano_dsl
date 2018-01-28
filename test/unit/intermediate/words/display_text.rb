require_relative '../../../../lib/tyrano_dsl/intermediate/words/display_text'
require_relative 'words_base_test'

class IntermediateWords::DisplayTextTest < IntermediateWords::WordsBaseTest

  def setup
    super
    @display_text = TyranoDsl::Intermediate::Words::DisplayText.new
  end

  def test_missing_character
    assert_tyrano_exception('Unknown character [missing_character]') do
      @display_text.validation_phase(@context, @world, caller, character_name: 'missing_character', text: 'text')
    end
  end

  def test_ok_with_character
    declare_character(world, 'Shinji', default: '../../assets/characters/shinji/default_stance.jpg')
    @display_text.validation_phase(@context, @world, caller, character_name: 'Shinji', text: 'text')
  end

  def test_ok_no_character
    @display_text.validation_phase(@context, @world, caller, character_name: 'Shinji', text: 'text')
  end

end
