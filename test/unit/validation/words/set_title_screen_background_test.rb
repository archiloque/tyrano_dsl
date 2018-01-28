require_relative '../../../../lib/tyrano_dsl/validation/words/set_title_screen_background'
require_relative 'words_base_test'

class ValidationWords::SetTitleScreenBackgroundTest < ValidationWords::WordsBaseTest

  def setup
    super
    @set_title_screen_background = TyranoDsl::Validation::Words::SetTitleScreenBackground.new
  end

  def test_unknown_background
    assert_tyrano_exception('Unknown background [missing background]') do
      @set_title_screen_background.validation_phase(@context, @world, caller, background_name: 'missing background')
    end
  end

  def test_two_backgrounds
    declare_background(@world, 'background 1', 'background.png')
    @world.title_screen.background = 'background'
    assert_tyrano_exception('Title screen background already defined') do
      @set_title_screen_background.validation_phase(@context, @world, caller, background_name: 'background 1')
    end
  end

  def test_ok
    declare_background(@world, 'background 1', 'background.png')
    @set_title_screen_background.validation_phase(@context, @world, caller, background_name: 'background 1')
    assert_equal 'background 1', @world.title_screen.background
  end

end
