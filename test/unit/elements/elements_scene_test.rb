require_relative '../../test_helper'
require_relative '../../../lib/tyrano_dsl/elements/scene'

class ElementsSceneTest < Minitest::Test

  def test_background
    scene = TyranoDsl::Elements::Scene.new('my_scene')
    assert_equal('my_scene', scene.name)
  end

end