require_relative '../../test_helper'
require_relative '../../../lib/tyrano_dsl/elements/scene'

class SceneTest < Minitest::Test

  def test_background
    scene = TyranoDsl::Elements::Scene.new('my_scene', 20)
    assert_equal(scene.name, 'my_scene')
    assert_equal(scene.target_name, 'scene20')
  end

end