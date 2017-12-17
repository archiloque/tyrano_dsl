require_relative '../../../lib/tyrano_dsl/elements/scene'
require_relative '../../../lib/tyrano_dsl/parser'
require_relative 'parsing_words_helper'

class StartSceneTest < Minitest::Test

  include ParsingWordsHelper

  def test_duplicate
    parser = create_parser
    parser.context.world.scenes['scene name'] = TyranoDsl::Elements::Scene.new('scene name', 1)
    begin
      parser.start_scene 'scene name'
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match(/Line \d+ duplicated scene \[scene name\]/, e.message)
    end
  end

  def test_ok
    parser = create_parser
    parser.start_scene 'scene name'
    assert_equal(parser.context.words.length, 1)
    assert_equal(parser.context.words[0].word, TyranoDsl::Vocabulary::START_SCENE)
    assert_kind_of(Array, parser.context.words[0].word_location)
    assert_equal(parser.context.words[0].parameters, {:name => 'scene name'})
    assert_equal(parser.context.world.scenes.length, 1)
    assert_equal(parser.context.world.scenes.keys.first, 'scene name')
    assert_equal(parser.context.world.scenes.values.first.name, 'scene name')
    assert_equal(parser.context.world.scenes.values.first.target_name, 'scene1')
  end

end
