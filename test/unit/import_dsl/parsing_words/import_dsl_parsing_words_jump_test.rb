require_relative 'import_dsl_parsing_words_test_helper'

class ImportDslParsingWordsJumpTest < Minitest::Test

  include ParsingWordsTestHelper

  def test_ok_with_scene
    parser = create_parser
    parser.jump('target scene', 'target label')
    assert_equal(1, parser.context.world.jump_targets.length)
    jump_target = parser.context.world.jump_targets.first
    assert_equal('target scene', jump_target.scene)
    assert_equal('target label', jump_target.label.name)
    assert_word_equal(
        TyranoDsl::Vocabulary::JUMP,
        {scene_name: 'target scene', :label_name => 'target label'},
        parser
    )
  end

  def test_ok_without_scene
    parser = create_parser
    parser.jump('target scene')
    assert_equal(1, parser.context.world.jump_targets.length)
    jump_target = parser.context.world.jump_targets.first
    assert_equal('target scene', jump_target.scene)
    assert_nil jump_target.label
    assert_word_equal(
        TyranoDsl::Vocabulary::JUMP,
        {scene_name: 'target scene', :label_name => nil},
        parser
    )
  end

end
