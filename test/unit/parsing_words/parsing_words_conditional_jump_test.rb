require_relative 'parsing_words_test_helper'

class ParsingWordsConditionalJumpTest < Minitest::Test

  include ParsingWordsTestHelper

  def test_ok_variable
    parser = create_parser
    declare_variable(parser.context.world, 'a', 10)
    declare_variable(parser.context.world, 'b', 20)
    parser.conditional_jump('a', '<', 'b', 'target scene', 'target label')
    assert_equal(1, parser.context.world.jump_targets.length)
    jump_target = parser.context.world.jump_targets.first
    assert_equal('target scene', jump_target.scene)
    assert_equal('target label', jump_target.label.name)
    assert_word_equal(
        TyranoDsl::Vocabulary::CONDITIONAL_JUMP,
        {:variable => 'a', :operator => '<', :value => 'b', :scene_name => 'target scene', :label_name => 'target label'},
        parser
    )
  end

  def test_ok_value
    parser = create_parser
    declare_variable(parser.context.world, 'a', 10)
    parser.conditional_jump('a', '<', 20, 'target scene', 'target label')
    assert_equal(1, parser.context.world.jump_targets.length)
    jump_target = parser.context.world.jump_targets.first
    assert_equal('target scene', jump_target.scene)
    assert_equal('target label', jump_target.label.name)
    assert_word_equal(
        TyranoDsl::Vocabulary::CONDITIONAL_JUMP,
        {:variable => 'a', :operator => '<', :value => 20, :scene_name => 'target scene', :label_name => 'target label'},
        parser
    )
  end

  def test_ok_without_scene
    parser = create_parser
    declare_variable(parser.context.world, 'a', 10)
    declare_variable(parser.context.world, 'b', 20)
    parser.conditional_jump('a', '<', 'b', 'target scene')
    assert_equal(1, parser.context.world.jump_targets.length)
    jump_target = parser.context.world.jump_targets.first
    assert_equal('target scene', jump_target.scene)
    assert_nil(jump_target.label)
    assert_word_equal(
        TyranoDsl::Vocabulary::CONDITIONAL_JUMP,
        {:variable => 'a', :operator => '<', :value => 'b', :scene_name => 'target scene', :label_name => nil},
        parser
    )
  end

  def test_unknown_variable
    parser = create_parser
    assert_tyrano_exception('Unknown variable [a], currently 0 defined: ') do
      parser.conditional_jump('a', '<', 10, 'target scene', 'target label')
    end

    parser = create_parser
    declare_variable(parser.context.world, ' a ', 10)
    assert_tyrano_exception('Unknown variable [a], currently 1 defined: [ a ]') do
      parser.conditional_jump('a', '<', 10, 'target scene', 'target label')
    end
  end

  def test_unknown_operator
    parser = create_parser
    declare_variable(parser.context.world, ' a ', 10)
    assert_tyrano_exception('Unknown operator [ ? ]') do
      parser.conditional_jump(' a ', ' ? ', 10, ' target scene ', ' target label ')
    end
  end

  def test_unknown_value_variable
    parser = create_parser
    declare_variable(parser.context.world, 'a', 10)
    assert_tyrano_exception('Unknown variable [b], currently 1 defined: [a]') do
      parser.conditional_jump('a', '?', 'b', 'target scene', 'target label')
    end
  end

end
