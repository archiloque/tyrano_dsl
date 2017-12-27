require_relative '../../test_helper'
require_relative '../../../lib/tyrano_dsl/elements/title_screen'

class ElementsTitleScreenTest < Minitest::Test

  def test_title_screen
    title_screen = TyranoDsl::Elements::TitleScreen.new
    title_screen.background = 'my_backgroud'
    title_screen.first_scene_name = 'first scene'
    assert_equal('my_backgroud', title_screen.background)
    assert_equal('first scene', title_screen.first_scene_name)
  end

end