require_relative 'parsing_words_test_helper'

class ParsingWordsStartSceneTest < Minitest::Test

  include ParsingWordsTestHelper

  def test_duplicate
    parser = create_parser
    parser.context.world.scenes['scene name'] = TyranoDsl::Elements::Scene.new('scene name', 1)
    assert_tyrano_exception('Duplicated scene [scene name]') do
      parser.start_scene 'scene name'
    end
  end

  def test_ok
    parser = create_parser
    parser.start_scene 'scene name'
    assert_equal(1, parser.context.world.scenes.length)
    assert_equal('scene name', parser.context.world.scenes.keys.first)
    assert_equal('scene name', parser.context.world.scenes.values.first.name)
    assert_equal('scene1', parser.context.world.scenes.values.first.target_name)
    assert_word_equal(
        TyranoDsl::Vocabulary::START_SCENE,
        {:name => 'scene name'},
        parser
    )
  end

end
