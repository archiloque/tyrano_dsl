require_relative '../../../../lib/tyrano_dsl/validation/words/set_background'
require_relative 'words_base_test'

class ValidationWords::SetBackgroundTest < ValidationWords::WordsBaseTest

  def setup
    super
    @set_background = TyranoDsl::Validation::Words::SetBackground.new
  end

  def test_missing_background
    assert_tyrano_exception('Unknown background [missing_background]') do
      @set_background.validation_phase(@context, @world, caller, background_name: 'missing_background')
    end
  end

  def test_ok
    declare_background(@world, 'background', '../../assets/backgrounds/school.jpg')
    @set_background.validation_phase(@context, @world, caller, background_name: 'background')
  end

end
