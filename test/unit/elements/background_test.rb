require_relative '../../test_helper'
require_relative '../../../lib/tyrano_dsl/elements/background'

class BackgroundTest < Minitest::Test

  def test_background
    background = TyranoDsl::Elements::Background.new('background', 'path/to/background.png', 20)
    assert_equal(background.name, 'background')
    assert_equal(background.image_path, 'path/to/background.png')
    assert_equal(background.target_short_file_name, '20.png')
    assert_equal(background.target_long_file_name, 'data/bgimage/20.png')
  end

end