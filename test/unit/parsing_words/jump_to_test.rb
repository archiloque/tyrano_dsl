require_relative 'parsing_words_helper'
require_relative '../../../lib/tyrano_dsl/parser'

class JumpToTest < Minitest::Test

  include ParsingWordsHelper

  def test_ok
    parser = create_parser
    parser.jump_to('target scene', 'target label')
    assert_equal parser.context.world.jump_targets.length, 1
    assert_equal parser.context.world.jump_targets.scene_name, 'target scene'
    assert_equal parser.context.world.jump_targets.label_name, 'target label'
    assert_equal parser.context.words[0].word, TyranoDsl::Vocabulary::JUMP_TO
    assert_kind_of Array, parser.context.words[0].word_location
    assert_equal parser.context.words[0].parameters, {scene_name: 'target scene', :label_name => 'target label'}
  end

end
