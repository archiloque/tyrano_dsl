require_relative '../../test_helper'
require_relative '../../../lib/tyrano_dsl/elements/background'

class ElementsBackgroundTest < Minitest::Test

  def test_background
    background = TyranoDsl::Elements::Background.new('background', 'path/to/background.png')
    assert_equal('background', background.name)
    assert_equal('path/to/background.png', background.image_path)
  end

end