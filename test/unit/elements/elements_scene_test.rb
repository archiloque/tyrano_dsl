require_relative '../../test_helper'
require_relative '../../../lib/tyrano_dsl/elements/scene'

class ElementsSceneTest < Minitest::Test

  def test_background
    scene = TyranoDsl::Elements::Scene.new('my_scene', 20)
    assert_equal('my_scene', scene.name)
    assert_equal('scene20', scene.target_name)
  end

end