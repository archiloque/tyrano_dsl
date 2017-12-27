require_relative '../../test_helper'
require_relative '../../../lib/tyrano_dsl/elements/background'

class ElementsBackgroundTest < Minitest::Test

  def test_background
    background = TyranoDsl::Elements::Background.new('background', 'path/to/background.png', 20)
    assert_equal('background', background.name)
    assert_equal('path/to/background.png', background.image_path)
    assert_equal('20.png', background.target_short_file_name)
    assert_equal('data/bgimage/20.png', background.target_long_file_name)
  end

end