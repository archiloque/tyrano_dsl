require_relative 'parsing_words_test_helper'

class ParsingWordsConditionalJumpTest < Minitest::Test

  include ParsingWordsTestHelper

  def test_ok_variable
    parser = create_parser
    declare_variable(parser.context.world, 'a', 10)
    declare_variable(parser.context.world, 'b', 20)
    parser.conditional_jump('a', '<', 'b', 'target scene', 'target label')
    assert_equal(parser.context.world.jump_targets.length, 1)
    jump_target = parser.context.world.jump_targets.first
    assert_equal(jump_target.scene, 'target scene')
    assert_equal(jump_target.label.name, 'target label')
    assert_equal(parser.context.words[0].word, TyranoDsl::Vocabulary::CONDITIONAL_JUMP)
    assert_kind_of(Array, parser.context.words[0].word_location)
    assert_equal(parser.context.words[0].parameters, :variable => 'a', :operator => '<', :value => 'b', :scene_name => 'target scene', :label_name => 'target label')
  end

  def test_ok_value
    parser = create_parser
    declare_variable(parser.context.world, 'a', 10)
    parser.conditional_jump('a', '<', 20, 'target scene', 'target label')
    assert_equal(parser.context.world.jump_targets.length, 1)
    jump_target = parser.context.world.jump_targets.first
    assert_equal(jump_target.scene, 'target scene')
    assert_equal(jump_target.label.name, 'target label')
    assert_equal(parser.context.words[0].word, TyranoDsl::Vocabulary::CONDITIONAL_JUMP)
    assert_kind_of(Array, parser.context.words[0].word_location)
    assert_equal(parser.context.words[0].parameters, :variable => 'a', :operator => '<', :value => 20, :scene_name => 'target scene', :label_name => 'target label')
  end

  def test_ok_without_scene
    parser = create_parser
    declare_variable(parser.context.world, 'a', 10)
    declare_variable(parser.context.world, 'b', 20)
    parser.conditional_jump('a', '<', 'b', 'target scene')
    assert_equal(parser.context.world.jump_targets.length, 1)
    jump_target = parser.context.world.jump_targets.first
    assert_equal(jump_target.scene, 'target scene')
    assert_nil(jump_target.label)
    assert_equal(parser.context.words[0].word, TyranoDsl::Vocabulary::CONDITIONAL_JUMP)
    assert_kind_of(Array, parser.context.words[0].word_location)
    assert_equal(parser.context.words[0].parameters, :variable => 'a', :operator => '<', :value => 'b', :scene_name => 'target scene', :label_name => nil)
  end

  def test_unknown_variable
    parser = create_parser
    begin
      parser.conditional_jump('a', '<', 10, 'target scene', 'target label')
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match(/Line \d+ unknown variable \[a\], currently defined: /, e.message)
    end
  end

  def test_unknown_operator
    parser = create_parser
    declare_variable(parser.context.world, 'a', 10)
    begin
      parser.conditional_jump('a', '?', 10, 'target scene', 'target label')
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match(/Line \d+ unknown operator \[\?\]/, e.message)
    end
  end

  def test_unknown_value_variable
    parser = create_parser
    declare_variable(parser.context.world, 'a', 10)
    begin
      parser.conditional_jump('a', '?', 'b', 'target scene', 'target label')
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match(/Line \d+ unknown variable \[b\], currently defined: a/, e.message)
    end
  end

end
