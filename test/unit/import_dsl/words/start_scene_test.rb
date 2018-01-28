require_relative 'words_base_test'

class ImportDslWords::StartSceneTest < ImportDslWords::WordsBaseTest

  def test_ok
    @parser = create_parser
    @parser.start_scene 'scene name'
    assert_word_equal(
        TyranoDsl::Vocabulary::START_SCENE,
        :scene_name => 'scene name'
    )
  end

end
