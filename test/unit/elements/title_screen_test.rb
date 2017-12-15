require_relative '../../test_helper'
require_relative '../../../lib/tyrano_dsl/elements/title_screen'

class TitleScreenTest < Minitest::Test

  def test_title_screen
    title_screen = TyranoDsl::Elements::TitleScreen.new
    title_screen.background = 'my_backgroud'
    title_screen.first_scene_name = 'first scene'
    assert_equal title_screen.background, 'my_backgroud'
    assert_equal title_screen.first_scene_name, 'first scene'
  end

end