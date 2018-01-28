require_relative '../../../../lib/tyrano_dsl/validation/words/start_scene'
require_relative 'words_base_test'

class ValidationWords::StartSceneTest < ValidationWords::WordsBaseTest

  def setup
    super
    @start_scene = TyranoDsl::Validation::Words::StartScene.new
  end

  def test_duplicate
    @world.scenes['scene name'] = TyranoDsl::Elements::Scene.new('scene name')
    assert_tyrano_exception('Duplicated scene [scene name]') do
      @start_scene.world_construction_phase(
          @context,
          @world,
          caller,
          scene_name: 'scene name'
      )
    end
  end

  def test_ok
    @start_scene.world_construction_phase(
        @context,
        @world,
        caller,
        scene_name: 'scene name'
    )
    assert_equal(1, @world.scenes.length)
    assert_equal('scene name', @world.scenes.keys.first)
    assert_equal('scene name', @world.scenes.values.first.name)
  end

end
