require_relative 'parsing_words_test_helper'

class ParsingWordsJumpTest < Minitest::Test

  include ParsingWordsTestHelper

  def test_ok_with_scene
    parser = create_parser
    parser.jump('target scene', 'target label')
    assert_equal(parser.context.world.jump_targets.length, 1)
    jump_target = parser.context.world.jump_targets.first
    assert_equal(jump_target.scene, 'target scene')
    assert_equal(jump_target.label.name, 'target label')
    assert_equal(parser.context.words[0].word, TyranoDsl::Vocabulary::JUMP)
    assert_kind_of(Array, parser.context.words[0].word_location)
    assert_equal(parser.context.words[0].parameters, scene_name: 'target scene', :label_name => 'target label')
  end

  def test_ok_without_scene
    parser = create_parser
    parser.jump('target scene')
    assert_equal(parser.context.world.jump_targets.length, 1)
    jump_target = parser.context.world.jump_targets.first
    assert_equal(jump_target.scene, 'target scene')
    assert_nil jump_target.label
    assert_equal(parser.context.words[0].word, TyranoDsl::Vocabulary::JUMP)
    assert_kind_of(Array, parser.context.words[0].word_location)
    assert_equal(parser.context.words[0].parameters, scene_name: 'target scene', :label_name => nil)
  end

end